Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA30C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 13:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66BB10E147;
	Tue, 12 Apr 2022 13:59:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A595710E147
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 13:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR7zYmIIS29lLRBob/mCjT/Oirqy6IWhXKcpehmn0QL9CiVJBJcvipJYZ5wGq7di3nXsjmjo7lGNTOplnKr4Tg75yDs+NF9okGHTdeYcekX6ES2fquejegSZO6b+ncmRxgdWM8EKfsZSqyhC47nI1BeJQjWelQuwBFxEU0GmcPETz4wtAsLJDllEPDzTIphIlLXgqQuNejgAEt7oBqdQ2pUORp3EGiksvsgDA2Wc10l+Esf9K1gfcGTPksb6WeCU0ndTAKncgqjGEQ8qQ4g/BBlUjqM1xbnnz7o93To5nufJcdsfUDZRWo5GTUnCEz9qDpZAROnSodRR9o4HK8OeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cpyqFQTHzOL5oxyVISkygwKqcc3LQFYGOrR6Pk4EPU=;
 b=fNKHLraaY+v5JC6lfVxwWbc7nD6DuUCpcSAg72PjCJ8prQ019K5D5ejn3+txkCy8+qt89UB4dVi9abPMph8C24XIxqwVqedE5xq1rTwl9QMI57KLLQLgGIC5M2Q/3bFNiMHiJp3x4K8iFqZJ7lbOXnraJfQHdOAdeZh0fKamAugnYtoVulM1QZ3WMq7qP44plFDsXE3ueClwZ+ljuNzO3f2Rn/yo1r5cY9woR8x7XpYQ0Ff6PkRntozmTFBeeCpQa9UbC9UTWdgQrEQLtXhXfiykb+Yavkaz3u26YnuTSnRLcTrbiooIjzmnMqqiYjRRWSGXjFl6Pg9l+zUMUsKu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cpyqFQTHzOL5oxyVISkygwKqcc3LQFYGOrR6Pk4EPU=;
 b=JZJhB8ZExatXzd/PKzpOrdp//5LT74onsCEuZQ099el+9Hqb0lGRsbwffW//b44v0nj6gvT4HCOTlVmL8rRdBOmBKj5sVJ1frPwOldLiQ1y5cAnx5SW1Uxii5uMnGpp22k9CG7muuHEb05C9ZPakxRqt9iJ1CK/kyXfGzbA0xWQ=
Received: from DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29)
 by DM6PR12MB3337.namprd12.prod.outlook.com (2603:10b6:5:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:59:25 +0000
Received: from DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::58c7:fc3b:9fc3:d926]) by DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::58c7:fc3b:9fc3:d926%7]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 13:59:25 +0000
From: "Wong, Alice" <Shiwei.Wong@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Thread-Topic: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Thread-Index: AQHYTm+OdsbnHMXIg0u8Tiq/KiObHazsTeoA
Date: Tue, 12 Apr 2022 13:59:25 +0000
Message-ID: <DM6PR12MB3963C4CFBC24E51B122BE3CFEBED9@DM6PR12MB3963.namprd12.prod.outlook.com>
References: <20220412131628.1121961-1-yongqiang.sun@amd.com>
In-Reply-To: <20220412131628.1121961-1-yongqiang.sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-12T13:58:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=043620f7-9764-44d6-90e1-69f6fda34828;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-12T13:59:23Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 068efc9a-5c76-4caa-8b71-b38bb66fc001
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd30177c-d0e6-42c3-8f26-08da1c8ca75d
x-ms-traffictypediagnostic: DM6PR12MB3337:EE_
x-microsoft-antispam-prvs: <DM6PR12MB333715D097F1304070C1AE2BEBED9@DM6PR12MB3337.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e647mk6nKLI2lp7QbCuaFTV37ZI5vssripiOLzu+U908GWRk/rp8Gxg3kT3oXpulh5KImjRpNMIw1vgtXR4ejM7D1+aY3E6dA9Q4MD4/WXDG7Dqo35DJ9ZPDty11tGmHMJP4dqlJDLwFeF2/2y5iHrj8PPIltMzmTURE7mhxwP7fUKuOACfHycWYmOHq493Flu7Ce7mJIbvUEvzdSHiI3lbtuExpc1QYT8SvUrC6nq8eAGa0rboUF58oqy+n6OckDC1HllFZc/aJnQIwupPh/DDHKIfwaYgluwPjpquPyELLy4Q/Jo2Gd+l7aWrb1+o3RnaBV5oHJz8uOtJ6LnaJQks0oObs5wbfUr8svNiUv1ofXGKijDf/beeYP9q+S3+QEsR71ra3Q+1oIPChxyoSWPcZOy41dx3CHoZJ7Xj3YvnPlIUrRSDAcKy1bco6p6bdwQJOMmwuZ2PoTfkvKBNSFPs5uVonFRYWXg8cXiPSO0c1Hc0V55bGmx4WsbUgsZenMZiIrqZiBQakhoxULyko6uoD015fcv6DeIbpR0t8wMWgS5ThgmEG3z6CMIXVnMJxTCaFWdtKf8ukFS9iQSI8UWgBFcsHwhZ4tXEPsSQWLIfsXvFfMwuDUcWiMYcaGz0ZupjWAJew7eEmT3OExE7nimXeGu7QaD6l7sgA9XaD2IcORfvhHlPolit1/4rcY1lI7+MvHUgAsnU7PMMOUGCeiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3963.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(316002)(110136005)(38100700002)(55016003)(83380400001)(9686003)(33656002)(66556008)(26005)(66946007)(38070700005)(66446008)(8676002)(4326008)(186003)(508600001)(76116006)(64756008)(66476007)(86362001)(53546011)(71200400001)(6506007)(7696005)(8936002)(5660300002)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3tuGSn8oFq7Fm1KBjbw5kXR33hyhIvZC9Z3eXsBfEtWlZcYPpYra3Ahjkf6q?=
 =?us-ascii?Q?CcIC9559uMRgxdmy1S1O6HSm32Cm21RWYpt93r3MAizHTE+p3QcJId2f5DYb?=
 =?us-ascii?Q?iZvDo2Vj5znYCmBqdNlRV+KdiL6u9KSomO9/etm8msvwEYkZ5UPxr6IAAOSH?=
 =?us-ascii?Q?r5JfeBEe7XX7hVqsP4XdmyKEn1tv2vCtOCuD1/Vjsrm/kb70LBNeJ67I5uZM?=
 =?us-ascii?Q?EJTPFLWN1fPYxri9lC4fMmWABggFN+mUsiDEjZi9svu2INjQoy813ktcfRRr?=
 =?us-ascii?Q?SZ8EbHqwwRXrjIw3vh/UKe+kDRq2CCsx6QXgyMQlYx6VROOdRAWs2N49yoGJ?=
 =?us-ascii?Q?w6Xj9117pBtEaYbDRNImVzLxdQuPSw4NWhmBjalxwBUHRkq/dKDVG1M6xJvq?=
 =?us-ascii?Q?ijmTNnFn19KF/u5SWS6kjBGtwOzJNTIwHpnFiMBkW61cWltJheF83X6J/8tx?=
 =?us-ascii?Q?15BMUG3AyIlBkBUKYKNpmUtt2GI/qd3ZNVMjPI1tTNKZ3TZGa8yErGKBuFgk?=
 =?us-ascii?Q?cm6B7O12wFmZRgSy5IMJZPQvZ5IH+Xu8u8Ya/dla9E8+EoRl69T/+FI/bfgc?=
 =?us-ascii?Q?BK8JeHPGbKZnDUbfe1ohm9wROCmrU110s5GG5K+HkEi4ALtClZszw1X5xMI9?=
 =?us-ascii?Q?tWkAbdowgogJpuDARX3VyT01KmNdeM1bQkslVf9ORqZ5pMrflL9KpUEnYv8P?=
 =?us-ascii?Q?5w9NRQ6tVGLKDRl093XxTsCy+oK4FKbVK0GYQd9dYRssEkpHmasdUNUoyPru?=
 =?us-ascii?Q?+z9G2TfGbeEPJ65gzeWVHxDBfqQ1ITkBuKtRLcGUzn4kt2VsQX0HMILYlkzd?=
 =?us-ascii?Q?83uC81jcpnn4Jazo17+FSPfveQPr5hNii2WFoaxv7qFNfYfHtjKsnNrsOV6p?=
 =?us-ascii?Q?HCnlFdduGgOpDVJY9Q5+Ldhp7m5CzE7lJrFsbz0rbVjo59HfedUkhRzXUxJx?=
 =?us-ascii?Q?AGYMgynW/pYFAefD3dHJDto1Y2ysJsM0kXtu3q+G56vHH2hBXHEESdRfJfU4?=
 =?us-ascii?Q?62iClRp9kgveqnfhtrpStYTv3maK4wym7LGrVj6TuFvliMX5v24BpxS2gwJH?=
 =?us-ascii?Q?VnqanChORGZpBVfumefIwHHxGq7lYFNVumw356NIQ26+HjAiOBnO/+w1RHue?=
 =?us-ascii?Q?kWESNnosIQ7BfJAsnzbhLrnbAf1Ku97C/WGN8ugGzE+CvQzG+SPFgKP30nXI?=
 =?us-ascii?Q?RvfbkinEUbPy46PiHnqWCOJNg0sUsQZ2rf21U+gMdp+OA/ZJSxMC9tjgBLlf?=
 =?us-ascii?Q?5JrNYY24sOFlKW9Rbuf8N4yPDAsW86MTM/hvW5pIHRe5o+y6teY+zuHKUsPR?=
 =?us-ascii?Q?IdTkv8bQi9FVlqaPTXo8befVaMXNEKYBrY8N5GYs/ydZndsbyomG1uXeoatR?=
 =?us-ascii?Q?K7XDVz3srkyLQx9ubSW7K5J2D9y+EFrYOiFCI7DF+N0XYd6IamJBhj4qYxid?=
 =?us-ascii?Q?euwMXlelWt8Ho30iNR89cUa91ef9TuM+ECzfheWBjMhrozXKAZ5Tdeavej88?=
 =?us-ascii?Q?F1WjggbNfZzc3VXwJIb3ijh37VudgH3Oa0/GYCFT2Lez+IHE9OOryOWf6t6O?=
 =?us-ascii?Q?sq/JdCu8XPKo9fSy/Dg1b9k57yr9M0lt8VvxKYIQgbsBrETEjj8vn2qqAOig?=
 =?us-ascii?Q?dkoOh1hLdBrkiTEz8PytplbxQadJtYPPEMeEM/S7PI+4lyST+Dds4ADYcZdD?=
 =?us-ascii?Q?THWic8BdQsPnWTDA0BthAAaOw95nuCx0kJflfVzvTNcnjXwj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd30177c-d0e6-42c3-8f26-08da1c8ca75d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 13:59:25.4022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7PPmB9G5RfHI7Csz2pY5DJhAEptL+ubTK1s6qS+pR62PkRgIwdC6K4hiO5k4l0V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3337
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
Cc: "Yao, Yiqing\(James\)" <YiQing.Yao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



-----Original Message-----
From: Sun, Yongqiang <Yongqiang.Sun@amd.com>=20
Sent: April 12, 2022 9:16 AM
To: amd-gfx@lists.freedesktop.org; Wong, Alice <Shiwei.Wong@amd.com>
Cc: Yao, Yiqing(James) <YiQing.Yao@amd.com>; Sun, Yongqiang <Yongqiang.Sun@=
amd.com>
Subject: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with v=
ega10

MS_HYPERV with vega10 doesn't have the interface to process request init da=
ta msg.

Check hypervisor type to not send the request for MS_HYPERV.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 933c41f77c92..d5eea031c3e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -23,6 +23,10 @@
=20
 #include <linux/module.h>
=20
+#ifdef CONFIG_X86
+#include <asm/hypervisor.h>
+#endif
+
 #include <drm/drm_drv.h>
=20
 #include "amdgpu.h"
@@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device=
 *adev)
 			break;
 		case CHIP_VEGA10:
 			soc15_set_virt_ops(adev);
-			/* send a dummy GPU_INIT_DATA request to host on vega10 */
-			amdgpu_virt_request_init_data(adev);
+#ifdef CONFIG_X86
+			/* not send GPU_INIT_DATA with MS_HYPERV*/
+			if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+#endif
+				/* send a dummy GPU_INIT_DATA request to host on vega10 */
+				amdgpu_virt_request_init_data(adev);
 			break;
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
--
2.25.1
