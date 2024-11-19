Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54B9D6007E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 08:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4581310E5F2;
	Tue, 19 Nov 2024 08:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnKUWtsp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB18910E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 08:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5Jc1vQEke1+BDu3Qdq4vJssX7h8Dig/VbpqQGFGg80J/XhmZpanwz0IWBhfLsxYFWnHb75MaP7EvcjzjELKki6yiVIa+XVHyFVLKqDhgzKHLHwZadPmr6/i5xcpLG4RBI7+rsrK6Q4vy/73MEh1svR+iWIxMnYUTps+r+WCUzvDChN6bPgUrEzSJCXk0QROdWMZG9p+GizBJku3YnEyjEo1a/V4EzhUKT8/Vv9Uijo/RzKf+zoTvHrenIHiTNvPfuEy41B/ZUQSoa9WTMP1wEY9xY+VMOTjY/KFP7bw+zPY9Dtgdpw9I+FTKdZzSqiSWPx7TnHzkzMxrCSSdf2mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7Y9buHAIPjw5i/gOEdo0omlQYGUYgTHlmbLPhh7YII=;
 b=jgxpFa3WJbEq58fnGn6FLoFobUDZKLLK4VzTc6d/P8XlXFpxNs9FxaEcAy44K0iEcrvlNXS3dTbweHQSaLe82fGzUQVhciNFTkN3dd5iMyLPw5m0x9VWEfW48dr79nEUr4lU/mWDkBCP1o8BiaAnZ0wrwDrMYUVK/gbA5sdmnlLtByzWvy+B0oOGuXZ4QhfFEhisDUQutF+kimhwDD1R0Zo7YkS2j4kaaS60OKej5o1RdOvmqgUgcI1JLOZDzwvJeZDDIZyjg72A8sdu8gr8u+FRYZM4e+8TbBgY1GDIpbVK+s2xZ25MzfBD0wXQofUsVMg08XYQOMdHYYcr7RFNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Y9buHAIPjw5i/gOEdo0omlQYGUYgTHlmbLPhh7YII=;
 b=xnKUWtsp4GW+Qhd0Hkbin6Yhds3ve/yuYZez1cioMC919n/T0l1+VziyfXfE7xpxvvV/p8Qk+cej8pKGr4HwuZxdGASL1YbAYejRngMqxz1yOW0VUO4tEHZYh9IGvPoTO63y/PcJSNqfMhyS+FeRTqWWfrYiTs/I8kaa6xtwWec=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 08:47:55 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:47:55 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Topic: [PATCH v2] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Index: AQHbObX1LCkdSdzkGkyOCD/hZ4lQvbK+Skeq
Date: Tue, 19 Nov 2024 08:47:55 +0000
Message-ID: <SA1PR12MB734309748AB9340AFC555028EB202@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241118101013.917462-1-shikang.fan@amd.com>
In-Reply-To: <20241118101013.917462-1-shikang.fan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T08:47:54.945Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|DM4PR12MB6613:EE_
x-ms-office365-filtering-correlation-id: bcd001b7-c485-4e7f-c33b-08dd0876dc66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vHNKndaLKXIjnXSDy/zw31o/Ztb4eBqDsdLC0h+7k5xrHgU0e2r+v12ImQ?=
 =?iso-8859-1?Q?utWlQlyGW0kKQ5jeYio6t0m3+7OQhXWpSRRRWTxc9ubCQ6ndY4EzVoEV7O?=
 =?iso-8859-1?Q?OHqGG8vH1FUK9i5Nen8OYgo0z0PAo3ZK8qO1nXFLu86GGBh7vpCUUyNnwp?=
 =?iso-8859-1?Q?Hsw5LiO/18e16UJaFvBJhwOfDvaAdayIuLFvRpN1+Xlf7F3lYA5WX5ZZFv?=
 =?iso-8859-1?Q?SIhMP6g0lGxVvdW+JhoTONylilnPBPR7qeqKOS+KpZJiiVESJHdZ5j9/7x?=
 =?iso-8859-1?Q?w0MjbvURt5B055P0RRYZD15Ce0ynhrBL3DXqFPmu5GPAPfU+pF7+XP3Sjd?=
 =?iso-8859-1?Q?8NRM7F3ikOnnP1NrnW2HnLxHCv1JsubmwL98JgzO/+PRiFIIE0FtEBq2rT?=
 =?iso-8859-1?Q?eY0VMMa/9q39eFp9kLZDDuYaD1gs+zgbayqcYQMNoGWB12CrPHRaJU9nCl?=
 =?iso-8859-1?Q?/CN3B5gJ1K64XVbLg0xiWFb8GFCY3E10QYYNcMWDXyNa9lPfGaxGmm4i1m?=
 =?iso-8859-1?Q?iy3pnK0OV1eSWUKCeZjApBaIgEeEtg5jP28+1rCWMYJoQodbT2NQgsFO9K?=
 =?iso-8859-1?Q?7/ycu1Q1Jb2c69Ne2TOum6Dz+RpkILtUZOp7pOYqGjVXFMrq+K/rWJx2Xq?=
 =?iso-8859-1?Q?JzWVz5SswLX2sXubunE4LeKmsKTIUZYl4zAigKPrhNhwT2oFpsKH8e+wr7?=
 =?iso-8859-1?Q?ekwJSiTbesOzL1WSjbdGPlrt8IX+ByWl6FEpMI+OlCt7XO4jHzZEWna9E2?=
 =?iso-8859-1?Q?kx5jscv5r4lk/OZKLItKN3oBp6NzqrwA23KLy7M8MLUcw3AnpAsjDlEgT0?=
 =?iso-8859-1?Q?lTd7FE0gAWCSz07eeazaSfTzeS0wrkf9SDd5VLxO7kCu0ExOojVmg265FE?=
 =?iso-8859-1?Q?b251OiD8I4UcCSKzzf2g7CfvxTo142DUHMYwPbjD2pex/3hzeSr3bDP3gZ?=
 =?iso-8859-1?Q?raShAifGYOLCAXhFxPspFW6cn2GkKqAPetYhmP4OmJ8PYAycnxeYP5J64B?=
 =?iso-8859-1?Q?10mi13sfqAXKVwjtlO+mYuPf5SO7sJSs6Yf1sZo7keZaVH+ow8YszlNW3b?=
 =?iso-8859-1?Q?1g1NNW0SnB3KegzluXDrEcr84QlbCWNR3HE4xtToM25XC1qiWwojzoR794?=
 =?iso-8859-1?Q?c0DwKclRE0n0VNCs7hLZX46aPqTrjs9J+YrUKFK/GWTqE8bj3+GmAKo0ge?=
 =?iso-8859-1?Q?y0NN3GhvE+6hQ2arablDQUL1gSxd5YZbNsFP4mn/ycnk9R+9/GLfpVzrHH?=
 =?iso-8859-1?Q?8d6tFF51tveUj2YBBBXFwo3yYKdeWUoAAgnpHEmIJAC2fcoXDt1xBJ0U/f?=
 =?iso-8859-1?Q?vns/fxuU5BKz1G9SGL3ygvUABjKedGG8/jRgTj+eyY58HYzMe6ttfSpiaX?=
 =?iso-8859-1?Q?zv7WhYxrQ6SV0t2yGHzZEUi+R1nCveM7TH4oG3SpHJ+OhkEcy3MbY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5XOw0Ni7ZhLKdl/A3Cn4oxiRwok2+fFmBiYdjOpxFNtVrnE1Zj7g+5WzrQ?=
 =?iso-8859-1?Q?ShzGM/ZdpiH0VwgvTunvY5l/bfpoqnMoyopZvl2ekIlvCS6ljXuRPMqA6b?=
 =?iso-8859-1?Q?SJR0eCKDw41FW7MIushYQmyOZ6UTezDEFwab9Hr99xaVpE+5xElYTLhj6u?=
 =?iso-8859-1?Q?HatCxe54BwseQrsj2p/UxjH4xtqL8/yxm9biCrA8V9yutkwJsb7KgFLmir?=
 =?iso-8859-1?Q?IFNdIVTdN+BoDYUt6zqmnbWi1o4dJyi8jUt17Ad7WEDCmFthCMOKJXvlUB?=
 =?iso-8859-1?Q?opMSztIR8rIqozTfXVoOrAHp4gwPmZCuNILwJ4afYK382UDS1LDw2QGDiq?=
 =?iso-8859-1?Q?ia1HT9MX1aBGKY//Nny1ZkOSZkn/2Zv6lxf7TiHnneyKRgM1RXRLDzbPPb?=
 =?iso-8859-1?Q?YJ9NVbyT3yLLak8FrVXFqf0VzMp6kF7Fw8i8m5XuA1dQjdc6PEBBTuA+bm?=
 =?iso-8859-1?Q?hqE95T3IkjxIc5P/qyTIc3tVz/Hrff1SisFMwW090myUYT9RE3pfBKTIsL?=
 =?iso-8859-1?Q?gXCtKDsyBjVprFEDnlYMa1ZwAORlN6OYnZotusC/KBHy3257v61LxRkiis?=
 =?iso-8859-1?Q?HfJuxQ/wgcp8Sy7Cir/AGW289p71EYmj6IpwPbwcC4e+vcl86vY8dzEGIl?=
 =?iso-8859-1?Q?6Zg2vjLh0IP+0tc883+RctFqTNC8AzkDDeBs1ZO/n2NZ0/hSzAq7rKJ+8A?=
 =?iso-8859-1?Q?C+0KZoGa+2sGy8f53B+ThJs2epu/C92DHh4c0OW9alzH3jfloC2R9muTK2?=
 =?iso-8859-1?Q?K8EZrDjh+hDr6WbB+QEYb8Qv7iNbTbC4rXXApfl3Huon0F0aZnN4cBIVTL?=
 =?iso-8859-1?Q?V6zj7ZmeF8wtTT+aUky5PTSYB7A59Amp5FcxfyoecoA0G2ZD1sePMclQaP?=
 =?iso-8859-1?Q?1rV0452iHkEs98YPvV+OTxlLTg4eK16dfTwj7H3ZcxskAbDagZld7Bjb6t?=
 =?iso-8859-1?Q?Yb0iOWjp8PJb2/MI4Atnn75bbHhuG4411en19cCT/cIbupmlTlEJh1qwpY?=
 =?iso-8859-1?Q?zasVJY9DwA4hZ9/IaPETv/rfPc9uMMrvbdOC+MbcfZio4/Dyl6CtXhQPUA?=
 =?iso-8859-1?Q?c4/FcASchi2hAfK9oJrc51XIHndH03NZ6YcExiy9+FuFEXESfsVSWXKR5k?=
 =?iso-8859-1?Q?uYFiq7EZ38yrh0PyVquD4NUCGypOzg/ZYi/WSh4J44Gd4b5ny5AJtxYmai?=
 =?iso-8859-1?Q?8T0e/Q8/xMe8It9S4iRPzFCmN/KFo+btcWP7+n/ZbQPtxsifmoRgzR9kNW?=
 =?iso-8859-1?Q?AngXcXCSDcgY4esLPOj4jNj8hoA7uJZn55UiLqTg2X+Z6HhBsODz24Fpn9?=
 =?iso-8859-1?Q?Vb8vqoER+Xz5oI8Vwz/b2XVJA4cbmihE7oAHIIL7vpVHUKYqd1xXuPcKG7?=
 =?iso-8859-1?Q?VSxp7zvs+eWGVDnIiGqGW8hIdfHmg64rS2BZuWhaeyHLzZ9+4PMgUzXDao?=
 =?iso-8859-1?Q?9s4p82Q3GqxPVQFDILR00jtUyfmo+j4w+OgOuHGiKb0cZu+gDlHXAp9K1h?=
 =?iso-8859-1?Q?td5s8AILUy48PM1OknrAvecsb6qAsIuIEpHDZkXEFFbrZccHj71korX9Wk?=
 =?iso-8859-1?Q?Uz/DnsSBlgmbWxpPHEoQrv2ePPr5TPtaWasmM4t4KYIABBpWqVFzPOoBfz?=
 =?iso-8859-1?Q?PAPHBFjMGKxa8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB734309748AB9340AFC555028EB202SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd001b7-c485-4e7f-c33b-08dd0876dc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 08:47:55.2995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWR0QELhPvH5GSdT/ZRxDpcMVs57XECfXmKSMQp7nK6HejFdLLBkkiJJcHNamey2cPBdGzWWY/VSFoOnDAiE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SA1PR12MB734309748AB9340AFC555028EB202SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

+@Koenig, Christian<mailto:Christian.Koenig@amd.com>

Hi Christian,

Could you please help take a look at this patch? Compared to the previous p=
atch, we now use amdgpu_fence_emitted_count to check unfinished jobs. And t=
his function is currently only used for mailbox_flr_work In SRIOV case, soI=
 believe the modification on this function will not have any impact on the =
rest part of the driver. Thanks for your advice on v1 patch.

Regards,
Shikang

________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Monday, November 18, 2024 6:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Check fence emitted count to identify bad j=
obs

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b3ca911e55d6..ea756eacebdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+#define AMDGPU_PENDING_JOB_TIMEOUT     (1000000)

 static const struct drm_driver amdgpu_kms_driver;

@@ -5222,15 +5223,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
 }

 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver recei=
ves
+ * FLR notification from host driver. If there are still jobs running and =
not
+ * signaled after 1s, the hardware is most likely hung already, then the g=
uest
+ * driver will not respond the FLR reset. Instead, let the job hit the tim=
eout
+ * and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-       int i;
+       int i, j;
         struct drm_sched_job *job;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5244,12 @@ bool amdgpu_device_has_job_running(struct amdgpu_de=
vice *adev)
                 if (!amdgpu_ring_sched_ready(ring))
                         continue;

-               spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
-               spin_unlock(&ring->sched.job_list_lock);
-               if (job)
+               for (j =3D 0; j < AMDGPU_PENDING_JOB_TIMEOUT; j++) {
+                       if (!amdgpu_fence_count_emitted(ring))
+                               break;
+                       udelay(1);
+               }
+               if (j =3D=3D AMDGPU_PENDING_JOB_TIMEOUT)
                         return true;
         }
         return false;
--
2.34.1


--_000_SA1PR12MB734309748AB9340AFC555028EB202SA1PR12MB7343namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
+<a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWAAM957748" class=3D"tW=
KOu mention ms-bgc-nlr ms-fcl-b">@Koenig, Christian</a><br>
<br>
Hi Christian,<br>
<br>
Could you please help take a look&nbsp;at this patch? Compared to the previ=
ous patch, we now use amdgpu_fence_emitted_count to check unfinished jobs. =
And this function is currently only used for mailbox_flr_work In SRIOV case=
, soI believe the modification on this
 function will not have any impact on the rest part of the driver. Thanks f=
or your advice on v1 patch.<br>
<br>
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Shikan=
g Fan &lt;shikang.fan@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, November 18, 2024 6:10 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; Deng, Emily &lt;E=
mily.Deng@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v2] drm/amdgpu: Check fence emitted count to id=
entify bad jobs</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">In SRIOV, when host driver performs MODE 1 =
reset and notifies FLR to<br>
guest driver, there is a small chance that there is no job running on hw<br=
>
but the driver has not updated the pending list yet, causing the driver<br>
not respond the FLR request. Modify the has_job_running function to<br>
make sure if there is still running job.<br>
<br>
v2: Use amdgpu_fence_count_emitted to determine job running status.<br>
<br>
Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++-------=
-<br>
&nbsp;1 file changed, 14 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b3ca911e55d6..ea756eacebdc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -100,6 +100,7 @@ MODULE_FIRMWARE(&quot;amdgpu/navi12_gpu_info.bin&quot;)=
;<br>
&nbsp;#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 &gt;&gt; 2)<br>
&nbsp;#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 &gt;&gt; 2)<br>
&nbsp;#define AMDGPU_PCIE_DATA_FALLBACK (0x3C &gt;&gt; 2)<br>
+#define AMDGPU_PENDING_JOB_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp; (1000000)<br>
&nbsp;<br>
&nbsp;static const struct drm_driver amdgpu_kms_driver;<br>
&nbsp;<br>
@@ -5222,15 +5223,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t<br>
+ * amdgpu_device_has_job_running - check if there is any unfinished job<br=
>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; *<br>
- * check if there is any job in mirror list<br>
+ * check if there is any job running on the device when guest driver recei=
ves<br>
+ * FLR notification from host driver. If there are still jobs running and =
not<br>
+ * signaled after 1s, the hardware is most likely hung already, then the g=
uest<br>
+ * driver will not respond the FLR reset. Instead, let the job hit the tim=
eout<br>
+ * and guest driver then issue the reset request.<br>
&nbsp; */<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
@@ -5239,11 +5244,12 @@ bool amdgpu_device_has_job_running(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; AMDGPU_PENDING_JOB_TIMEOUT; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_fenc=
e_count_emitted(ring))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (j =3D=3D AMDGPU_PENDING_JOB_TIMEOUT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB734309748AB9340AFC555028EB202SA1PR12MB7343namp_--
