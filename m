Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03B8C38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E705910E49D;
	Wed, 26 Oct 2022 09:05:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9A010E49D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 09:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqRRd+LJSCO0HzlrFSw7S0tU55qiJjllzMbs533IA9E36gmp5kdECmpzPERsQJ+6GlWvxPbm6m6bBVSEjp7RG1NfdAWlYB1YSsecnIXz6+cNTKtmXTptjp9/RMLTtgrVW4/eh2LmIDa7yiKna2SE0FHinDT1o5Iiuycj+yKMif0bkS1qLsF+nw9YrYE/G+LTDK2ChQBxv4fPI2CnJ4G/g5DDVQlLwXorBmpYvcu3a4F7bfDjcikHpzI3hIDbi6PoD7WgYk8olqj2h5VYUcJnyl8+uUpIX0MciwfMmD+uzBbmxo62EKk8x17XfkYT20rfqPvFdmmIYI/6zsSzA/ahtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjjSVyp80DugGyHwYpF4Ug3TuRa0rVcyXe0SVQ8YlCg=;
 b=UwIdjMP3VuEJVoGlrXyXtcQgGrcMoNcoXI2AuHkePWacnJGanj2+ZMIGl+J2NUMPTr6QTN5vRNnm75luXBKp8hmY89I9gVkXBR7wcdcLQhIc055Qp+qJhpt/FakcsKYcpieySsTXCNVE/auDBLVi/rgjimYJIJ4dQmpvVNO3faqjw207nngqVruWzG7CwmCf34wEIg/5kcd33Cr20A4yiMBi9+q6/yc509NqqwNdA+i6Fbjvt87/Y1dClnE1CuB3R6u+BXrTqNGFVm/miieTzSbqKG7ZC837DNeqA8w8ptKdtz4iSBmu3jCGgtXgleHnJsLOsrONofiJcqSJVv+4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjjSVyp80DugGyHwYpF4Ug3TuRa0rVcyXe0SVQ8YlCg=;
 b=MJv2hFV5xKBNbaYTpSkWHPXPrzXtDIVtXBwlbanp0R3gcxMn3TgHZaT2vOKDYCwy2yBy8W6WFgCqo8IqEMBUszVe1++t4uLhktY33wh3ywUnSy8iidwiffg52QiZlw/+YnGfZtlYHOIAwQXi9YWFOOzfalTmlq0Gf6XADcuTasU=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 26 Oct
 2022 09:05:00 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::8ae1:2617:d5dc:60e7]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::8ae1:2617:d5dc:60e7%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 09:05:00 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove deprecated MES version vars
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove deprecated MES version vars
Thread-Index: AQHY6Kb5M5BymSb+8kSb46n+l8tWvq4gYq6N
Date: Wed, 26 Oct 2022 09:05:00 +0000
Message-ID: <MW3PR12MB44589FDB98188F18D717BAD5EF309@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20221025192056.647389-1-Graham.Sider@amd.com>
 <20221025192056.647389-2-Graham.Sider@amd.com>
In-Reply-To: <20221025192056.647389-2-Graham.Sider@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-26T09:04:59.607Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|PH7PR12MB7236:EE_
x-ms-office365-filtering-correlation-id: 98f580b4-fa2e-48c7-0d0b-08dab731296d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8xu5koaIqFzNDJqu3an9u7w9a9xLnIxo5P5a74hPDQdml34kRwEG4nTmwI8eXzPEURzTiZO/545NfIAdHmO+TzC9o2YRCVSSGp4Q3PDohPwXY1UHc+GkbV1c+7xaKU+nsc12EEkZHQVmlynIQJ/olKX9LOGKc/bpfh2G4KxhxuVVZsfSlS1SKqy93bfGew9xdHanPT0unowVxncxatl7634d4nfQWwJClUxr1OhasrhbaEl7Hcnvh78rgwrhEiT/gsfmQZ0UZApgOIz5qwx7heR4pZNotTuf3oRPZy+9f8X0g3xmIW+UKgexASX1g7a3XAlHx066FU2TaeFM25Pr9ZjgBdFWtiWpOiumW84IJURa0CeGjRtqeaMIxS3HJ27aJDJJNWCkEIJhkzY3Se7PiYKQ3jWY/2kAhfyAf9sGcEowttR5GvGCkgoqPTqYB/HFp+8yxIpuyF6gTZHeVLgjQPwzATMEnGmRw67trLb2rKWhBQGGlFgvXG3I77qTbZVqJu6Vj0Ey/fJ4l133tmVOCV15P35TsH2sseGlCJN8ApgTMIHx8NoXdDkRX8xK8EH10hZifS+tv6lES363O/v/JGlrppeeivBwNOwiCifLoAZ4X4cKcVAcTbQKdjgGaXfG0vpEtyaNlixh5u8JbaiRGMNDs61+3X9McZ3J5otcZQV3vDSaG7whrc4cMpVQm1OJ0hRpX0M8Iz1TCnmZMUfb/srAp4O6VLnWARe0tk4A4ti/YxJ3s5Y5895atJWaV3wNpBK6k8WrFJmt4G4JsgPDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(7696005)(91956017)(53546011)(66446008)(66476007)(71200400001)(66946007)(8676002)(66556008)(4326008)(64756008)(33656002)(55016003)(38070700005)(316002)(6506007)(122000001)(86362001)(76116006)(9686003)(83380400001)(38100700002)(186003)(478600001)(19627405001)(41300700001)(52536014)(26005)(110136005)(5660300002)(2906002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ijPEB+yVWIWV4xolIe0qG85b8/OUEmIRLUh6hUlgB5ZS4p6iHTO/RtnuI02v?=
 =?us-ascii?Q?S2kt1/3wyIJnfOKYbW9sc/6Mjg6SRpMa/tbKs3so+RCc897OIeZzCmTQYJNp?=
 =?us-ascii?Q?NX/rPArnk6cT6axaBaAhV8R37hotF51AYk7bk4Siy3VDNRJ4M+r0g0nXH785?=
 =?us-ascii?Q?DI22/aI2mm9DrLvZjtTyQKUYAGNBYnFyV+uRXw4JruRv4ZyXy38AIg13/xTE?=
 =?us-ascii?Q?GrLtLVswseqlWWJ7+2L9ARVlnfz3+lTqjl9T5roEo8ri/EiYPQ2edIVAoZN8?=
 =?us-ascii?Q?/h4FH9FHFtUHQ5m2XSkm5yDVmtSftB0N4CQu/XCOSyP7UJ5P4Knq0juD7zcA?=
 =?us-ascii?Q?Hlre1MxWCDo/aFIdbu9hY/IiexK0iw8W2sOqIo+tr830khln9rATkiJlP1Ox?=
 =?us-ascii?Q?wgKPC0QJl/s0bK5Fb6qKst0pcx+EVYOL8l29nidotvhNg4O5vWIl7VaTYev8?=
 =?us-ascii?Q?m+VZM5qgMs1AjmFvVAwhBHjK/59FpUDIk/KPTQzc5o6WHjAg+3HXBb25WH+r?=
 =?us-ascii?Q?+EI2C0lI2gjMbIXdGeJC8Tsh7GTV/2J/QXLZ2dPIlgZVIyHabDur0ehQNZk4?=
 =?us-ascii?Q?ROpmS/T2MjbRVhaBeiN+prGIePWfsqN9qTsp6nrN7F6S4zRmiyNTcuOU0Wts?=
 =?us-ascii?Q?+hThIlSPEXjKKHmSGD9Qsoor0uiaVFHzAWL3cVRucdNz6zKBqdCuyal1i43v?=
 =?us-ascii?Q?uEFl2Hn3Rcjh4IkTe0rpnoSkZ9sGvDr1+crWcKX5mPaU5NtxyhfrEZFnSySU?=
 =?us-ascii?Q?tdBDy2lT8zv28dRVOMChMe1UnPyy6DAyFTf5fbGxa2iZzRwiwJjP0WxQFPGa?=
 =?us-ascii?Q?JCldjc55o8fREFxNs0lqNLYVZcxKxcs9v47+R/0/7MWeNaWLsKBWFHHVUmEP?=
 =?us-ascii?Q?zgbiq5r2RBpZ7KdKTmSV8mF7u178juzOqbzmqeJ2nrol3IUlCzg0H7v+tQCi?=
 =?us-ascii?Q?CYi0DsZv7j2V/arXxZMhqIHB82zq1D34Lo7OPFhJqpwGuyZxf15xvTfuLZ/0?=
 =?us-ascii?Q?bnQZ96m1qE0W1oJtudJe0TbP8KHt9Ctr+J+XnVj7405+KY5pTwgIyyi/2m3Q?=
 =?us-ascii?Q?1UKTXn0CpHr4mQnEj56GN3DXuTdRGh2OK6SITl7GRqt5mpWDTrFvoQu0Redu?=
 =?us-ascii?Q?yigsNIFQzpdJIxhJKhBhqNRxTWZBZPLAuPKGBsNvtVEFJewIB9Bcl46QlcNB?=
 =?us-ascii?Q?GJlY4dA1LwMn41G8/HnMWPfyxqHQFYKhrSsBwiJ62lhN521RYO+gVIJWtPUB?=
 =?us-ascii?Q?D0Eo8b9Mf4dyA+Uc1KM8vDI6X8+mvzujXXt5IdvS0EJ+waq1Zpv803fIya5u?=
 =?us-ascii?Q?NhEMdXo1hnYsP4z7NI2wWWupDvVaGv/o64Op8b51MiV/gPAzBy5wBp/eSkHM?=
 =?us-ascii?Q?CzPE38B4m4PzCbyCjt/s416DwCARODpySS9RYA/JOHS9caNLRm4Gy0FG3M7C?=
 =?us-ascii?Q?GKG2q1AJ7aityXQY9fkFPUCNv8ZU1MrjklRZXLyAUauJO28XO5JCPpgl3ZnR?=
 =?us-ascii?Q?2XG7PQnzcRQeMwTcM7uoFL1av/BHHzhyHhRDkP0VeqxuIND//9TRXFDK7QLk?=
 =?us-ascii?Q?SxysEBklvZiLfzP28JI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB44589FDB98188F18D717BAD5EF309MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f580b4-fa2e-48c7-0d0b-08dab731296d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 09:05:00.2483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZoNnrQIhW9bEuIyWnZvKJ7sTm5O/dsnUyvh3vXL5tFvzF1ccGpLoNX3TiYfEdko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB44589FDB98188F18D717BAD5EF309MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

The series is Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>

Regards,
Jack
________________________________
From: Sider, Graham <Graham.Sider@amd.com>
Sent: Wednesday, 26 October 2022 03:20
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove deprecated MES version vars

MES scheduler and kiq versions are stored in mes.sched_version and
mes.kiq_version, respectively, which are read from a register after
their queues are initialized. Remove mes.ucode_fw_version and
mes.data_fw_version which tried to read this versioning info from the
firmware headers (which don't contain this information).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 4 ----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ----
 3 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index ad980f4b66e1..97c05d08a551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -91,14 +91,12 @@ struct amdgpu_mes {
         struct amdgpu_bo                *ucode_fw_obj[AMDGPU_MAX_MES_PIPES=
];
         uint64_t                        ucode_fw_gpu_addr[AMDGPU_MAX_MES_P=
IPES];
         uint32_t                        *ucode_fw_ptr[AMDGPU_MAX_MES_PIPES=
];
-       uint32_t                        ucode_fw_version[AMDGPU_MAX_MES_PIP=
ES];
         uint64_t                        uc_start_addr[AMDGPU_MAX_MES_PIPES=
];

         /* mes ucode data */
         struct amdgpu_bo                *data_fw_obj[AMDGPU_MAX_MES_PIPES]=
;
         uint64_t                        data_fw_gpu_addr[AMDGPU_MAX_MES_PI=
PES];
         uint32_t                        *data_fw_ptr[AMDGPU_MAX_MES_PIPES]=
;
-       uint32_t                        data_fw_version[AMDGPU_MAX_MES_PIPE=
S];
         uint64_t                        data_start_addr[AMDGPU_MAX_MES_PIP=
ES];

         /* eop gpu obj */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v10_1.c
index 067d10073a56..1abdf8b7ab50 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -415,10 +415,6 @@ static int mes_v10_1_init_microcode(struct amdgpu_devi=
ce *adev,

         mes_hdr =3D (const struct mes_firmware_header_v1_0 *)
                 adev->mes.fw[pipe]->data;
-       adev->mes.ucode_fw_version[pipe] =3D
-               le32_to_cpu(mes_hdr->mes_ucode_version);
-       adev->mes.ucode_fw_version[pipe] =3D
-               le32_to_cpu(mes_hdr->mes_ucode_data_version);
         adev->mes.uc_start_addr[pipe] =3D
                 le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
                 ((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) <<=
 32);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index e14f314902b1..27a330f51c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -480,10 +480,6 @@ static int mes_v11_0_init_microcode(struct amdgpu_devi=
ce *adev,

         mes_hdr =3D (const struct mes_firmware_header_v1_0 *)
                 adev->mes.fw[pipe]->data;
-       adev->mes.ucode_fw_version[pipe] =3D
-               le32_to_cpu(mes_hdr->mes_ucode_version);
-       adev->mes.ucode_fw_version[pipe] =3D
-               le32_to_cpu(mes_hdr->mes_ucode_data_version);
         adev->mes.uc_start_addr[pipe] =3D
                 le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
                 ((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) <<=
 32);
--
2.25.1


--_000_MW3PR12MB44589FDB98188F18D717BAD5EF309MW3PR12MB4458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
The series is&nbsp;<span style=3D"font-size:12pt;margin:0px;color:black;bac=
kground-color:rgb(255, 255, 255)" class=3D"ContentPasted0">Reviewed-by:&nbs=
p;Jack Xiao &lt;Jack.Xiao@amd.com&gt;</span>
<div style=3D"font-size:12pt;margin:0px;color:black;background-color:rgb(25=
5, 255, 255)">
<br class=3D"ContentPasted0">
</div>
<div style=3D"font-size:12pt;margin:0px;color:black;background-color:rgb(25=
5, 255, 255)" class=3D"ContentPasted0">
Regards,</div>
<span style=3D"font-size:12pt;margin:0px;color:black;background-color:rgb(2=
55, 255, 255)" class=3D"ContentPasted0">Jack</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sider, Graham &lt;Gra=
ham.Sider@amd.com&gt;<br>
<b>Sent:</b> Wednesday, 26 October 2022 03:20<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;; Sider, Graham &lt;Graham.Sider@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: remove deprecated MES version vars<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MES scheduler and kiq versions are stored in mes.s=
ched_version and<br>
mes.kiq_version, respectively, which are read from a register after<br>
their queues are initialized. Remove mes.ucode_fw_version and<br>
mes.data_fw_version which tried to read this versioning info from the<br>
firmware headers (which don't contain this information).<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v10_1.c&nbsp; | 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; | 4 ----<br>
&nbsp;3 files changed, 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index ad980f4b66e1..97c05d08a551 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -91,14 +91,12 @@ struct amdgpu_mes {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *ucode_fw_obj[AMDGPU_MAX_MES_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode_fw_gpu_addr[AMDGPU_MAX_=
MES_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ucode_fw_ptr[AMDGPU_MAX_MES_=
PIPES];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode_fw_version[AMDGPU_MAX_MES_PIPES];<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uc_start_addr[AMDGPU_MAX_MES_=
PIPES];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mes ucode data */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; *data_fw_obj[AMDGPU_MAX_MES_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_fw_gpu_addr[AMDGPU_MAX_M=
ES_PIPES];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *data_fw_ptr[AMDGPU_MAX_MES_P=
IPES];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_fw_version[AMDGPU_MAX_MES_PIPES];<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_start_addr[AMDGPU_MAX_ME=
S_PIPES];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* eop gpu obj */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v10_1.c<br>
index 067d10073a56..1abdf8b7ab50 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c<br>
@@ -415,10 +415,6 @@ static int mes_v10_1_init_microcode(struct amdgpu_devi=
ce *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_hdr =3D (const struct =
mes_firmware_header_v1_0 *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.fw[pipe]-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ucode_fw_version[pipe] =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; le32_to_cpu(mes_hdr-&gt;mes_ucode_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ucode_fw_version[pipe] =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; le32_to_cpu(mes_hdr-&gt;mes_ucode_data_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.uc_start_addr=
[pipe] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(mes_hdr-&gt;mes_uc_start_addr_lo) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((uint64_t)(le32_to_cpu(mes_hdr-&gt;mes_uc_start_addr=
_hi)) &lt;&lt; 32);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index e14f314902b1..27a330f51c7d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -480,10 +480,6 @@ static int mes_v11_0_init_microcode(struct amdgpu_devi=
ce *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_hdr =3D (const struct =
mes_firmware_header_v1_0 *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.fw[pipe]-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ucode_fw_version[pipe] =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; le32_to_cpu(mes_hdr-&gt;mes_ucode_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ucode_fw_version[pipe] =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; le32_to_cpu(mes_hdr-&gt;mes_ucode_data_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.uc_start_addr=
[pipe] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(mes_hdr-&gt;mes_uc_start_addr_lo) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((uint64_t)(le32_to_cpu(mes_hdr-&gt;mes_uc_start_addr=
_hi)) &lt;&lt; 32);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44589FDB98188F18D717BAD5EF309MW3PR12MB4458namp_--
