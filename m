Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF20C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 05:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B55110E858;
	Wed, 19 Jun 2024 05:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ItWwRXan";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D949110E879
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 05:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYRS0C777NlujfbYEnD2Y3tJh5jI4krlr8lfCALfmHzXWeAK57Jjl455yhZ0bBM0OyR4Af/o+su9gKuy9cisvh68yl2nEO5TAoKHcouNUzMRKvFVhwIXHY+j2tZ1t4Fd8RgFGNX1O88JX2BQY0dqV1gaIUWvtVt155eY1cSiE5Wnbe6ds6ox5TaX5Ozuhmh9AJzy5/OqpjNEvSwxy3hju1txDp05ODUiVw/ZVCnYJ8NljAtiJlmFpbJFBSIoKuUawAorouOWr6LU9WvnDGUIvdekkXkowMsiOsiRJrltLfk6ateKz8KRMYEF4UJ8mrbY2nCoARfuButQEZPUeSVC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPhoRiMwOc50zjIhAxck8qmwy1AQu7CzP8tXJPAnoSQ=;
 b=KK2KuXmoRt0H0IUWBbUcltfLQDLNIzSzAlfAsCYmxdR2/AUwsEFKKoKe6E8MuQ+xj7f26IlVL3wtISA8830JnfISJ0XxANbW2C21WwkgCq2DLjZlS6QrkibGk+Jk/PDuVWl5lyVb2UN99d+AQ6UgZ4jCfyd+bvxZaqlqSNnwcGsUgeiaEOMn9K6Nc9bNk6w+viDaH7mMc8YlUrFhV/Q6tABwe59wJVlUpZ4X2ezprJjF7hbqNvCXLxnjfd81V/verHd2CWlsYFr8yy+jomE8cNS5v+qPFzk59q7IpfUBlAilhJNkOjif6xiRJQrAZcu942fqZ+bd+cTFh5o5dyKHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPhoRiMwOc50zjIhAxck8qmwy1AQu7CzP8tXJPAnoSQ=;
 b=ItWwRXanGhPhMqtzrayFw1+v3/P3YYtnk8XAxKAgsHwhf68c7/sjna5Z8NkI+ZmKa7F5V7i7QDe4ZoEGePMj5/6tDlaRGk1qVtbURKSSLTx1IHfbvH7qn2G98ydAQ+sEZhg4y6mXu65fzY60VmJD09009w+p4PO7j3Rc2Tz3PuU=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 19 Jun
 2024 05:49:24 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 05:49:24 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/jpeg5: reprogram doorbell setting after power
 up for each playback
Thread-Topic: [PATCH] drm/amdgpu/jpeg5: reprogram doorbell setting after power
 up for each playback
Thread-Index: AQHawZ45YH/08GvE4EiCHh5RQFiqIrHOlXlQ
Date: Wed, 19 Jun 2024 05:49:24 +0000
Message-ID: <DM4PR12MB51657FECB2CB0E01B3AE86328ECF2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240618163953.699473-1-sonny.jiang@amd.com>
In-Reply-To: <20240618163953.699473-1-sonny.jiang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7b05d3ed-37e0-4c7e-af51-8039ada704fb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T05:48:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH8PR12MB6843:EE_
x-ms-office365-filtering-correlation-id: 68f35d93-752b-4f74-65e0-08dc90239305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?6b3S1jKWwZSD65FTHFLH5UAGrG7ScZBp/iBiMuYXHuZD114fKoCLXG+8DeVe?=
 =?us-ascii?Q?npuVtkTxPzs1nBdnc6eknllnVnxF7vv9cqg/KbcEsyeQtFOB78FdaM7kYwyT?=
 =?us-ascii?Q?a6EZA+yOSQNzN67iRkRHc+3PbHyCMJiyELHzXOfA7OvizRUfGQ7mnRytulld?=
 =?us-ascii?Q?oUAqNziqep6OtsshmEqbebu3HUsSNND6QIruUHnswL+7kV3e7CchxWWmUDiJ?=
 =?us-ascii?Q?0EXjzybQFK09Td/QCTQYR24qFPH8ACw5FUHqTW7RewihMlpJ/Kfxk5zFKrN/?=
 =?us-ascii?Q?1tIYAUMCiUGN1P5bc7uDb1yPDB8JfU1YIq+NLMKd44QpP8TjFmye2HHJBlLa?=
 =?us-ascii?Q?Y/ezlG7/zworpjXXFwDz21OGe7b56iT1zyg4dQ4WN9uQrqod87XYCBzDo1h7?=
 =?us-ascii?Q?KaXhzXvajDNrGog0ZHxG1WzCSpTUpGFTk4WckSzQ184oEnWJN4hmKM2f1ffc?=
 =?us-ascii?Q?i8klv9elBP/lpo7neo/oZ0NjsfRI/S1DMVF/vFFBExsE5NE+dpfZdPSfpvOb?=
 =?us-ascii?Q?QX64sFGI1uNL+a2zTdLaBohVGob48X96cPnPJxphZ2lwYS9Fuw83JF8Z2ba/?=
 =?us-ascii?Q?Ce1bZkot1y/P/KlENQXWaNFydYT718ESvZsz+80ZUIF7T2n18RYw8UuvEVMy?=
 =?us-ascii?Q?Rz31h9+sGY23RuJ7J2quON8gHJ4uMEQ74t/p+643Cqyriqdl4cSc/5VijsOA?=
 =?us-ascii?Q?gXImBp24PAppWqm0tzBKrf18A7O/iVvTZjicG5raeyM2aQU8ZITHdl0RRtJU?=
 =?us-ascii?Q?MZvkXYxiUZz62I8esSEJEJ+NXw011bzKvnd30FRe5Cz0pSlCSLfXjvGBXMrX?=
 =?us-ascii?Q?ctea3ZNmuyVDcBcIt+2rWkd5WsTjD2DDpoawxjFnPS4r88uSkObG1QB64B5n?=
 =?us-ascii?Q?LTdz47x//GVL7Uu+9TkBXsH5z813sqke17vXDnUVxm4va5z25YPDwuoaLsYU?=
 =?us-ascii?Q?BhMSQDcggU+1ERlFmlQaRyl8N7uKhvCtumortOAmlkQPeXAqA8WfVQ3wzNxk?=
 =?us-ascii?Q?0PSsRWKhNCg9LidnokOrbCSlMVUomrOOLbvpyAC/FpCJKLRD8tfU0E1qLldp?=
 =?us-ascii?Q?pXThpPBnM34ZOR6kOU/ZwcoG+6AuxVCaD6qJzwFZAhUbgQQFEJ6OWMpeH8nP?=
 =?us-ascii?Q?ZiBTSp7nbjLOynK7ceLoyF5zpTmhx0naqzQ8ysT87yJtA68bgbt1RC1uQ3WB?=
 =?us-ascii?Q?OkRw17ktSBg7kjHHFaz+tJoaQhOcwsFPJURVxLMz3rXtGxen77BlXDZ2YN/2?=
 =?us-ascii?Q?0pO8Zp1VvI5iJTvQMiH7T4JFSekS/FeojMA7jMs//vmGPJiv+JT6xH443veH?=
 =?us-ascii?Q?bMfNnLUBzys6TOfJSakRIOfyY2/uchz/RDO2D7DbOxjcSO2rNyXU+V16FKkH?=
 =?us-ascii?Q?ID4nTxg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdWmFCOyDyWSi8Ws71+niGV8QVjbYR56zoSS/hQqlWxLfQ8tlHfgVqgBAYKg?=
 =?us-ascii?Q?85zFmBFntBSuENG08fJZ2DCLaXgidnbrXMLDPWheSM/JWo7c+nzmOw9SKf8N?=
 =?us-ascii?Q?WpkUwxmUV/t/Ybvt05LknJf7CsIzfk9/xUKheZYIHrdnzXAlBcBJcm3IjfIP?=
 =?us-ascii?Q?/5QGtSq/afw/8LagryxCIi+fVB55rL6Th5GSLZ3AUb8GyLURMubSWVE8Ohu+?=
 =?us-ascii?Q?bVSlbcZx8yItkkVp0wig7+i9r+YHeALYJ6toO9hJxMOeT9M+HalriTPb/4Sr?=
 =?us-ascii?Q?1s48ZMvW19uN5D9kLVQEQ6ZT7515x9RN5ASxmzQygQJon5VkKoZRkdKnL2fW?=
 =?us-ascii?Q?FZ6zJUNqfhh8Ar6QtalhxGHtuACvW5HMB31vQayDTNwFeeH1jBE7gdjWyFYA?=
 =?us-ascii?Q?RXQbNVJz4qXQyNG7evgedQt24xAtx6P1epVm0Ug/fZye//Qiyza62uKRWLVQ?=
 =?us-ascii?Q?utmuU2N4IX+aSGKSgBJ6BJM6brD4/KGEzCUalHNGKJqbcfeYsbdYuTcrv4Ok?=
 =?us-ascii?Q?sgOdKz18qm24xZRULwjrqzVPalqkB32XeHaG7wuFwqkbQhTUiwSQTiXf8KEf?=
 =?us-ascii?Q?IwJSQ2uIqczTfLT6OxR6Rx+UgAjOAt4/yQWFISxorMWb++cVHsDRFWKsfb0t?=
 =?us-ascii?Q?IsxMrzkxJk8auYlNRE3R9RrAJKX6FLoZ5XH3HMQBEpE3Nhrk3zWSRHuBFnXu?=
 =?us-ascii?Q?xAfMJzmwI8FP3Dhoz35uGtcuUbSbk2IA1lBCinciXxKYXQfrfiRC61U85Onf?=
 =?us-ascii?Q?2vlrB3tvLrDJs8eFZEA23TXajRHCm5lZNAQEp2g65S0IKX6fNkDspmXecSzu?=
 =?us-ascii?Q?XyJY679mDc4KLDH2vfPqefa00Z90Z+q39KaOn0BQ4akrg7ZnWUCs+gAZ9/2f?=
 =?us-ascii?Q?Tl4vNRAtknb10rfuz/LxoR5PYadPHE7zxpUWstWK66SS3YoX2hBXrNApkbUK?=
 =?us-ascii?Q?yMSfVmHWlz/sJV0J1jlzJH7+2VODqyeBXd5tRqEW7qqAq3TXYzd48w02x8x3?=
 =?us-ascii?Q?bMnNhl+n1Obe+Ej7/JrLcE868vLE6aQ7J3obnxohiPb9QzyP6nI+GHUyb4VJ?=
 =?us-ascii?Q?7h4Y4R/m9AiKhbvVH+4ZZQ0ybaXA8YMVUC8jRILu9E5ZH05kUYI9H3+NLYBY?=
 =?us-ascii?Q?PuevJ1leFKdqNRFxp35UZ/vfS85xb7V2nBqrzX5y1hXDpqEz5Ew9GGhafo/3?=
 =?us-ascii?Q?w5IaMJAZNGdPb+qHuLR00gMZI298iaOjtMib+prbumbDL9SY06JCPC4sExAz?=
 =?us-ascii?Q?GaZj4V0pEqEsdScqIb9OyDZJGOmcFC7qppygZ80lruKP8BgUgfpOCeVE7Qj1?=
 =?us-ascii?Q?mLN1MVcfXZ/pVxhhTTwil4AmFBMKOd3swMnZ2QmofEu2lPp6lOedxMF/N86M?=
 =?us-ascii?Q?EboBAq8lggN22JBN9daBinSntZZZoKXOMT4/Fm11K5aoum2v80zquQuaADQu?=
 =?us-ascii?Q?a4XCciypVr+qUHRLv7aMZ3NZGrtNhtVBubyvHeVJ05tFe5Rq4rNLaOeKTLBB?=
 =?us-ascii?Q?+JBXRs5yIfVPbsGefSX7FP/eGq71Nwtsai8Ut5xEnyRlef9WRGpOI23tVeby?=
 =?us-ascii?Q?/lNGZGNhsn2MEcgR76g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f35d93-752b-4f74-65e0-08dc90239305
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 05:49:24.3999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwosgK30Fsm+XkSsl5dL6e92nrRrpDSpdkF8bJ9NMVNH3pKO3ESYOdAP/vxaRgkZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sonny Ji=
ang
Sent: Wednesday, June 19, 2024 12:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg5: reprogram doorbell setting after power u=
p for each playback

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


From: Sonny Jiang <sonjiang@amd.com>

Doorbell needs to be configured after power up during each playback

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v5_0_0.c
index 68ef29bc70e2..e766b9463759 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -137,10 +137,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
        adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
                        (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);

-       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
-                       ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__S=
HIFT |
-                       VCN_JPEG_DB_CTRL__EN_MASK);
-
        r =3D amdgpu_ring_test_helper(ring);
        if (r)
                return r;
@@ -314,6 +310,10 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *ade=
v)
                JPEG_SYS_INT_EN__DJRBC0_MASK,
                ~JPEG_SYS_INT_EN__DJRBC0_MASK);

+       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+               ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+               VCN_JPEG_DB_CTRL__EN_MASK);
+
        WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
        WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x0000000=
2L));
        WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
--
2.45.1

