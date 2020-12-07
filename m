Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A28C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 16:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3544123750
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 16:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3544123750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D263F6E88B;
	Mon,  7 Dec 2020 16:16:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B49A6E88B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 16:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QItpKnwg+qDL+gQ9Xkk7rcl/aJv9j7fzf3FvKHjZ21YD2M25KbROIm/CnWPfx13UGjkSqsdqsQvnCkeZQYkEGHzO607ZNbq75Aq6kyqYTHVQQqo9hF0kC0k8oxhaoZjzt+2dvnHPoOO8uO+Td9UbKWaGewE3C4Pq/71YrtImGrikYgyfU/MF74d5l37CtzHmOlSB1rJP6VBCXzwrcRgJGPEq3vbLaE4wY+PLCt535KXJMQjtGZi6+yWyFVdC9v9bvNYn70i86juw/VZT+778x8zAtn+1VEp/gaCJXfJ2wOWlYt1kV6o5s2mNXQQHe+XN5D2bOPuVMqDQEm3tqirVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrHfAxalBgXSQPXFeDfJQjwq/8TxNUA0suca0Ttdj8w=;
 b=WhkcdCHqQ4zx+SQ47OgRIL6EVibFP0swEzR51HJuf/WLXwiniSVli/aTwWWDjR5Jtc5xeDilAFHkgS3Ta7/gTxlfLE/WMkPsS/Lpyann1yqowY5LS0RJAka3cJKGf2KyDPgPiCgcsWBSI+e3ZnLd53aAM4RiFWU4J2aB8iphDiT/3J3f5c9OhyoTbZc6uwMzZFL3cxixkjKt90jaMOUnAvCIOsdcpAlE4MB10La1H1OJS4O6CMIPfD1k4RRxLHEf73NuA1zE5Bbr1gp3MqS2YTUTMWqhA5rbcwKBHcxz96tXCIBrfYkpHwYz0ehQqvoZi5hn4ouYuXxMYxJgmDGBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrHfAxalBgXSQPXFeDfJQjwq/8TxNUA0suca0Ttdj8w=;
 b=vDWU3Do6jkgXwbeJMJY9HTLKRRA1sLJSxPu4F+3l1LdwwDsrKlVs2txVQ1VCesN23wsFwbof8DfBNDkg5GA0jxClcbANWEdoYekrSTRWwNMmjGkuBXWO/TQA+nsoLcX+vG1zU5aDpUjjwo550kH6mSxYJQvy6me6veFsprDcug8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Mon, 7 Dec 2020 16:16:37 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 16:16:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Index: AQHWzICtKH9iL7mSG0a+TM0H1YomEKnrzl/g
Date: Mon, 7 Dec 2020 16:16:37 +0000
Message-ID: <DM6PR12MB407541859F78FDB91937FB43FCCE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201207100623.1353365-1-jianzh@amd.com>
In-Reply-To: <20201207100623.1353365-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-07T16:16:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ab3fde45-80c7-4b65-87cd-d72ee198d983;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bf1b0d9-deec-434c-000d-08d89acb7932
x-ms-traffictypediagnostic: DM5PR12MB1867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB186774FFDBAF6CF882C24F3FFCCE0@DM5PR12MB1867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rX7L5L24dPyLbte2hXoUnRUDFM48ksndXmLoK1tb6sh9IgN2DUf50Dd/ZoxAmCt3051Z9ZqwmhjYmKeFhKDRg2Dld/FREfOoQivswXZ6oasH2IwFS0RXwkQcEjKcF6bzMMwXqZAlU3D+GZA7lfHHwHcCpKgKL467jhb+rvlYACoiemU1NZfqaqLBWFbOKv1/TgIgQZCPKxvebeSU+DzzDOPE/SK+GKxmgLGt2+Riu5bCwq48BjMv5FTM5ye5302X6c0wL2+hDzuYYH2Kgb3Zc2S+6QoVdbGT8RbvHlOO+ruxV0scDjlohGQSj3p9YpXr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(53546011)(8676002)(4326008)(71200400001)(9686003)(54906003)(55016002)(110136005)(66946007)(86362001)(478600001)(66476007)(6506007)(186003)(83380400001)(33656002)(26005)(66556008)(52536014)(2906002)(8936002)(7696005)(316002)(5660300002)(66446008)(76116006)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?feufVlgMS3LeCsbOczo2apvoa0cuirX9RBd7BMamF0GKxr38QhO7mqnbZk6M?=
 =?us-ascii?Q?Pbi/cpSv1gV2MmZjjq1+q65lLBU2qy6SLSOgQ/G+Z4RUtKRATBQRJz/6UvWt?=
 =?us-ascii?Q?EbculNIJNNKDhF4iv6fN0LQkMjOUZC+ypOFPXssYur2F+VNmZQPSVI1eXp4V?=
 =?us-ascii?Q?5kXBqrBT17LKlHP6AM6fd6krbNlpqoJIG3ScnPRU1lxykDMbWRd2+mYhaKc7?=
 =?us-ascii?Q?v6M5cWJpa1CTbXJiYLY6BJKQWFeIDT3c+bA3UJ/sA+o4QR5CN9GJgRGlrr3g?=
 =?us-ascii?Q?IC+qCva3O5fvUeTgUtNdk1vNIfeADXT8hDR3FpL+eMaR/Xq6Nx7A8T4ibyHf?=
 =?us-ascii?Q?j4/rL4OzuqHrHPe751kMGaJCFiZfPeb5FRmj6UHt7lDzZGBcZlzAJP3J/Mry?=
 =?us-ascii?Q?zK6HnbOfLTXcPBPRRN5cZUE/edx7hg+1NmNTcLFEOh/D+FGhneBzSCFoyvFR?=
 =?us-ascii?Q?D8IEAQ3C7NX5PSUSWg9H6yN1t1s6Kl+MgLOWGPEST8KY52BTdpHKu8tP135f?=
 =?us-ascii?Q?8B19cGeXP9uShNq1Y2Og04CSOu568NR+YH1TKr70XB5jfbq62M9Py74eRPqd?=
 =?us-ascii?Q?g6AXt98czBq/we8CG3Fvb3jNieEzgl3Z4sGb0My+qa4/3PAvgnJVkUxmExn0?=
 =?us-ascii?Q?yWggD38Rtzwr3waydDjwgpNtdiKgJjIT6Lm/xoc+BIdBtrZs69XIKS+CAwwb?=
 =?us-ascii?Q?i8QfR6H1Jzq8blgLCbzQJrHIHDF9VmeRp+gnN6Cyr32I6EzHlLAZghENZH+T?=
 =?us-ascii?Q?5iMHOn9FalusWrmS+a7wK+Ii9HWcGKWnytDNBddRt82LoTkMCZ2WA0AullZo?=
 =?us-ascii?Q?+xvV7s+TpWU7W9hKisukoV+qt7Tg+NsN+/cw3vYIpVjAMPtvs3OeoU8P4mnB?=
 =?us-ascii?Q?nQuHMERJtPCjoLylWiPOxv2ylcf/t1m1gjbwJhJXEFyqT0BmwOfoESl39L3T?=
 =?us-ascii?Q?9u/Av4YwyaPpM6QRgZfuHBDCffCE9gxfSjeIC5TNZP1WSp3GVxY5GmQ4Xv3Y?=
 =?us-ascii?Q?kbZe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf1b0d9-deec-434c-000d-08d89acb7932
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 16:16:37.4427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cP109f+3VHUxlJDAu0C+lgNpoqiLkwxrjfYXTzYW+pvtAoa3yOmRxFfi0TZXglS35mv5m8DSUAHwsdx42cDJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Re - Poll happens every 6 seconds and it will last for 60 seconds.
+	int ret, i = 0;
+	#define AI_MAILBOX_POLL_MSG_REP_MAX	11

The definition seems not match with your description that the polling will last for 60s.... with that fixed, the patch is

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhao, Jiange <Jiange.Zhao@amd.com> 
Sent: Monday, December 7, 2020 18:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Zhang, Andy <Andy.Zhang@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period

From: Jiange Zhao <Jiange.Zhao@amd.com>

In Virtualization case, when one VF is sending too many FLR requests, hypervisor would stop responding to this VF's request for a long period of time. This is called event guard. During this period of cooling time, guest driver should wait instead of doing other things. After this period of time, guest driver would resume reset process and return to normal.

Currently, guest driver would wait 12 seconds and return fail if it doesn't get response from host.

Solution: extend this waiting time in guest driver and poll response periodically. Poll happens every 6 seconds and it will last for 60 seconds.

v2: change the max repetition times from number to macro.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  3 ++-  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f5ce9a9f4cf5..7767ccca526b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 
 static int xgpu_ai_request_reset(struct amdgpu_device *adev)  {
-	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+	int ret, i = 0;
+
+	while (i < AI_MAILBOX_POLL_MSG_REP_MAX) {
+		ret = xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+		if (!ret)
+			break;
+		i++;
+	}
+
+	return ret;
 }
 
 static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 83b453f5d717..50572635d0f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,8 +25,9 @@
 #define __MXGPU_AI_H__
 
 #define AI_MAILBOX_POLL_ACK_TIMEDOUT	500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT	12000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT	5000
+#define AI_MAILBOX_POLL_MSG_REP_MAX	11
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 666ed99cc14b..dd5c1e6ce009 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 
 static int xgpu_nv_request_reset(struct amdgpu_device *adev)  {
-	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+	int ret, i = 0;
+
+	while (i < NV_MAILBOX_POLL_MSG_REP_MAX) {
+		ret = xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+		if (!ret)
+			break;
+		i++;
+	}
+
+	return ret;
 }
 
 static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 52605e14a1a5..9f5808616174 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -27,6 +27,7 @@
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT	500
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define NV_MAILBOX_POLL_FLR_TIMEDOUT	5000
+#define NV_MAILBOX_POLL_MSG_REP_MAX	11
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
