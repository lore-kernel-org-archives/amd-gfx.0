Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2FCC7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 01:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E034A10E284;
	Wed, 12 Apr 2023 01:23:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644B510E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 01:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCJSjOST8KPskllFpptxAFr2zt4jwMJAbUfRhYjTIo4dluJpZudF1sG9DDEjp0P5X/cNgVIuV03wr4wB/L/juvh14GsLj3ju1RrfA6R81YyJTetA6DWmFJSxPMXyPF4IgnqSZvj7wvpNUSlbBl75cTno/dvv+ICl/Xlm3HZ/ly4NvwEzWj4vMZTYJ9Ee7TeQpNceyOota8JVDkVGS49iqozBhuTrmBxxpHRhFh6eJr9vhiuSOFmJj+GbVJlUKLW2AIM95zlf78jI0/kRrGxMKW+7S14lN1vvXp+CiyUqsVaHGr/MQUxJqONyBtisuSC23aRgdddNSMMjXV1w4m5PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1zOic2H96C3m/+thVixd8sK8gs/o3NgN4ZGdu7SYJw=;
 b=QmidPv+bjLvAzYkwoCzDlg2IwFEtKKobhT0iUCVksIRpJJFxj13GFUBFsfnqa/JJF91D7VzDbDqZ3y19eUvDoC3PatxyzdZ1tbR1xu3LQ6K2j1ebxuPeN1HXPc7ac2/IhHErWQzTH0FiKNwEiaNbHQS3jcTNm0D1nwykxC6sRjg7r6mEePPagZfUJu6daTfSaCARzdl1PnIAy8umBNB1bjrGnxKD2cYObPCucvCkPZHxkPVWcObg0WutlQhN3hQk1fHWGPpp8DYlsmFRHNqEPyYQRGMxKEEKb0x6tmfSl8AosG10/PfmLG9knlwLuMIVko9tgLtGPYEN+ciGJhf59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1zOic2H96C3m/+thVixd8sK8gs/o3NgN4ZGdu7SYJw=;
 b=18VnFcB+FRtpJftkXhc2ZANdOy6ZCeIHR6Vz58rzzoJaP9CixiJV28C8BwvabRtIIhSfshcDN+9LrcA24CP4xxm5CYzzXNTb2X17xk3vTEXZ0Pk6E1YdE0iOC/jzk9AzJK6R0dFMQYRMaAmYbCK6zWTDa0FIH31NLo8nxaVZavs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 01:23:38 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::388e:83b6:f2cd:cd42]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::388e:83b6:f2cd:cd42%9]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 01:23:38 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, 
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: drm/amdgpu/gfx9: switch to golden tsc registers for raven/raven2
Thread-Topic: drm/amdgpu/gfx9: switch to golden tsc registers for raven/raven2
Thread-Index: Adls3RpnQ/cq4B8wTZCxajUc9u46Lg==
Date: Wed, 12 Apr 2023 01:23:38 +0000
Message-ID: <DM4PR12MB515262B810158F1D3C6E8324E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-12T01:23:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ba61d61e-8836-4ffe-8787-59a2a08321dd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-12T01:23:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 156a7d38-9b28-4fa1-b15a-4de494116285
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH2PR12MB4181:EE_
x-ms-office365-filtering-correlation-id: 821d0143-1644-4534-356f-08db3af48b39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nt/J20Vn6tc4tYSNsTBRaYxFY4GvkFTv6KuswyZS82TArgIPNCR5NfuFe6JLcNXerdsak8VdK3w3tEE3DcoA6rsObkx3KsDoEvjlTB0H/nAs7OYRPRQv0U7jXmi6PA9/zHUwDd2jrHy4tTE7Oi4gh7UNJNPf2F5p2DNJK4safF4FNgMIlAYr0eOzLk0BBBeLiqOw8mY+OnZl5ZxiiYL8Lzzh2b9T8/6ymdseqRBcWfEdajEXRCfBKfiBE9B1arLcluckYw5qwK5cWXxxXavLNGZ8PPPzORPnGF+nNN5lQVM1TLuHb0tTBi8TQUDTseWvnr6/G3atE87ag0JXfRiBgcC7W/pNyoP/IJZgJNPFPs72yw5N76hIJmooH9fyWog+pQV/oChHjXDamd479ZmpxouWgjzj3ud/YoOfdmRg4fUEOjT4ZdZ1rY152U2BykD4WWU9i9vnBpZBVgnH58NSZ1f74UkngIv0D0gHLMjoCA+iKg6f2X+f5umO+A62Vw40gIQf4FOOuweVy7uX09tq8P2peZ6hnp4nbSws52XIv55GvBzzHp6rfBOr0g6LH/AubSHShRwNwuu30nRZXJC0UNiE4O6zqukhlo/Vn6viwRcnXoCkSLUqdzHY0pCskp/z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(38100700002)(38070700005)(110136005)(6636002)(122000001)(66446008)(66476007)(64756008)(66946007)(8676002)(76116006)(86362001)(19627235002)(66556008)(478600001)(33656002)(186003)(26005)(316002)(41300700001)(2906002)(9686003)(71200400001)(6506007)(83380400001)(7696005)(52536014)(55016003)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K5ufSEjgmHlL5Z/hKZ6xbAE344ADNOx5ZfIoOMZQMbDVolBdvknsyqW7hTX9?=
 =?us-ascii?Q?2TcrWF4FjSvQWfl+/VuaGn2CbiCNMN/0H/8sq5To2t/zu/sjKszyWmJLpl5I?=
 =?us-ascii?Q?MXx2s8PxhhobKEKKihqQ+isdKaByuvXrBfvGPGl/gTy+UTwgIbQMFjWeSLnw?=
 =?us-ascii?Q?S+bOUyNtOqLKn23Dpn4pVELjZAdYAuZWdZXkCSbE5YaXpZYozqM7picN/Yea?=
 =?us-ascii?Q?GZt4S/ZZ5GRNBbljQcT1JzA3rNdlYRTFJFQoho19YnrPCLZI6xPOtd4l9Ffc?=
 =?us-ascii?Q?JccLcIwshYMdEcH/sD9MEe33h38ZzjtDEEeXop3H+A+kCmKG6WRamH8PuAJE?=
 =?us-ascii?Q?9SyMtzB2B8ryUwtdCEtSFT5iWVF2/Cja7FuurzE6ulcgMO2efXGRMjFKYlS0?=
 =?us-ascii?Q?NpxR6Qcq+KL106O7QBbpBUKEvtPWYgN2Mrl41nBv0z4vUN+2qISHEWPHtoT6?=
 =?us-ascii?Q?QUboJ4wWzmxAcyRKEdtITPaJBHekb/l+Pvo88ziJvHl/PdanmTp0L3Gs8V3k?=
 =?us-ascii?Q?JGD3kMiODAIWq+rYxI3j+nTc5MRZkRvxWbVTflKyX3gHRrBQLrxYfoDDrBSt?=
 =?us-ascii?Q?hwQbAiUG+UTvtL5hUmg6z6MtfHxnwGxFR+tOhiTw+/m6ZdG0gH8kbD5dimAu?=
 =?us-ascii?Q?BYJ6gJ5tSgfn3606QivZtmg1xsy12P4JCpNH26T4KPiMS3J5cDuLRtIHKf0k?=
 =?us-ascii?Q?rCO3cOJhoa9Xav+DPyYwEvhInB0dICIRl6Qj+0d2ymjHy04y0elyp7SauAu8?=
 =?us-ascii?Q?+X4ri7imSSwesbiYi6N7j++28WAfgKKd44wwZlXuSyGX6eEh70wNQKjKy1T7?=
 =?us-ascii?Q?c+1dmafkBGLauar9IzoFEPp0QuUO/kx+oEFIkjhAd56m4DCtOmV/8LRhu5Gu?=
 =?us-ascii?Q?uqTRdETcy1hCPV1cHJwlBjeBF+4joRqDVM/pIeFPpTFX2ILU89i9Bc5G0uQu?=
 =?us-ascii?Q?xXT8ZD1orW9pYwt//rjNzIgR5urIN0jqe1E9KI11K68Kg4WuOXLVyQbm+oCg?=
 =?us-ascii?Q?XndHgj/u42tx6l+gjdmbU8L7GM8E/lZe2NWPPs8zDx8wSyKDcqFtaXCtJgvB?=
 =?us-ascii?Q?10/Uhkd88/RzAlw9NVlnpNQpXAh3PxlrPjOohI3EOH4sGXUfzhox8TGooC9z?=
 =?us-ascii?Q?WNbdv2KlQXiYrtfMgkOgzQTflHsEbuoxzwfT6jmG7/i4+OhoamO1t9XU9Eii?=
 =?us-ascii?Q?IIwzd3DibtRtmAPpc2/b6w8jBmT/Q3NxeXIz74GC3K6xbv/Ownt7j2PzFNbU?=
 =?us-ascii?Q?QfESaQAtlirDMuJ/xjqamaDjCzT9cNnyd/6oeN1HWYD6W3vJy1w4/ZhNMZG2?=
 =?us-ascii?Q?bXEJ84CUokRmODOKAydDtYfcmbAF8JVtqPWs+puWiSGOfMH3eNAfk8jzSRX2?=
 =?us-ascii?Q?qfZzvpuNsaohZTQnTwVzsQj3xtfA44ldsRJqLEb7cR8CUlipxbmxaDtXqYz8?=
 =?us-ascii?Q?R4rQSL3O85HdQ7XaIiu8Hlk7+aHbVzz2xcd+GqkdEL337xvPJ6sEl0wUMPgL?=
 =?us-ascii?Q?toj3kki2u1vEv5GshlgUjWJXt9iR6+eXiS0u5ifCPilQQANAZRyMVYm0mRgG?=
 =?us-ascii?Q?MZs8rF468uosxue8YQM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB515262B810158F1D3C6E8324E39B9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d0143-1644-4534-356f-08db3af48b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 01:23:38.5261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFWE9SoaM9EZ6Mdfwz9Lvq2KEn68I44BhYYynpqb2OftmN5kWUAjotwswISMLr7eo7vFVRcS37LVVO7jQmKTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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

--_000_DM4PR12MB515262B810158F1D3C6E8324E39B9DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

  Due to raven/raven2 maybe enable  sclk slow down,
    they cannot get clock count by the RLC at the auto level of dpm perform=
ance.
    So switch to golden tsc register.
    Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.=
com>>
    Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index ae09fc1cfe6b..c99d9e642e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -149,6 +149,16 @@ MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec2.bin");
#define mmGOLDEN_TSC_COUNT_LOWER_Renoir                0x0026
#define mmGOLDEN_TSC_COUNT_LOWER_Renoir_BASE_IDX       1
+#define mmGOLDEN_TSC_COUNT_UPPER_Raven   0x007a
+#define mmGOLDEN_TSC_COUNT_UPPER_Raven_BASE_IDX 0
+#define mmGOLDEN_TSC_COUNT_LOWER_Raven   0x007b
+#define mmGOLDEN_TSC_COUNT_LOWER_Raven_BASE_IDX 0
+
+#define mmGOLDEN_TSC_COUNT_UPPER_Raven2   0x0068
+#define mmGOLDEN_TSC_COUNT_UPPER_Raven2_BASE_IDX 0
+#define mmGOLDEN_TSC_COUNT_LOWER_Raven2   0x0069
+#define mmGOLDEN_TSC_COUNT_LOWER_Raven2_BASE_IDX 0
+
enum ta_ras_gfx_subblock {
        /*CPC*/
        TA_RAS_BLOCK__GFX_CPC_INDEX_START =3D 0,
@@ -3988,6 +3998,36 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struc=
t amdgpu_device *adev)
                preempt_enable();
                clock =3D clock_lo | (clock_hi << 32ULL);
                break;
+       case IP_VERSION(9, 1, 0):
+               preempt_disable();
+               clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven);
+               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_LOWER_Raven);
+               hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven);
+               /* The PWR TSC clock frequency is 100MHz, which sets 32-bit=
 carry over
+                * roughly every 42 seconds.
+                */
+               if (hi_check !=3D clock_hi) {
+                       clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_LOWER_Raven);
+                       clock_hi =3D hi_check;
+               }
+               preempt_enable();
+               clock =3D clock_lo | (clock_hi << 32ULL);
+               break;
+       case IP_VERSION(9, 2, 2):
+               preempt_disable();
+               clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven2);
+               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_LOWER_Raven2);
+               hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT=
_UPPER_Raven2);
+               /* The PWR TSC clock frequency is 100MHz, which sets 32-bit=
 carry over
+                * roughly every 42 seconds.
+                */
+               if (hi_check !=3D clock_hi) {
+                       clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_T=
SC_COUNT_LOWER_Raven2);
+                       clock_hi =3D hi_check;
+               }
+               preempt_enable();
+               clock =3D clock_lo | (clock_hi << 32ULL);
+               break;
        default:
                amdgpu_gfx_off_ctrl(adev, false);
                mutex_lock(&adev->gfx.gpu_clock_mutex);

--_000_DM4PR12MB515262B810158F1D3C6E8324E39B9DM4PR12MB5152namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&nbsp; Due to raven/raven2 maybe enable&nbsp; sclk s=
low down,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; they cannot get clock count by th=
e RLC at the auto level of dpm performance.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; So switch to golden tsc register.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;Signed-off-by: Jesse Zhang &=
lt;<a href=3D"mailto:Jesse.Zhang@amd.com">Jesse.Zhang@amd.com</a>&gt;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Evan Quan &lt;<a h=
ref=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b=
/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index ae09fc1cfe6b..c99d9e642e51 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">@@ -149,6 +149,16 @@ MODULE_FIRMWARE(&quot;amdgpu/al=
debaran_sjt_mec2.bin&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">#define mmGOLDEN_TSC_COUNT_LOWER_Renoir&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x0026<o:p></o:p></p>
<p class=3D"MsoNormal">#define mmGOLDEN_TSC_COUNT_LOWER_Renoir_BASE_IDX&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_UPPER_Raven&nbsp;&nbsp; =
0x007a<o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_UPPER_Raven_BASE_IDX 0<o=
:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_LOWER_Raven&nbsp;&nbsp; =
0x007b<o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_LOWER_Raven_BASE_IDX 0<o=
:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_UPPER_Raven2&nbsp;&nbsp;=
 0x0068<o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_UPPER_Raven2_BASE_IDX 0<=
o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_LOWER_Raven2&nbsp;&nbsp;=
 0x0069<o:p></o:p></p>
<p class=3D"MsoNormal">+#define mmGOLDEN_TSC_COUNT_LOWER_Raven2_BASE_IDX 0<=
o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">enum ta_ras_gfx_subblock {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*CPC*/<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BL=
OCK__GFX_CPC_INDEX_START =3D 0,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -3988,6 +3998,36 @@ static uint64_t gfx_v9_0_get_=
gpu_clock_counter(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_enable();<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D clock_lo | (clock_hi &lt;&=
lt; 32ULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSIO=
N(9, 1, 0):<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_disable();<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_UPPER_Raven);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_LOWER_Raven);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_UPPER_Raven);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The PWR TSC clock frequency is 100MHz,=
 which sets 32-bit carry over<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * roughly every 42 seconds.<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hi_check !=3D clock_hi) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Ra=
ven);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; clock_hi =3D hi_check;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_enable();<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D clock_lo | (clock_hi &lt;&lt; 3=
2ULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSIO=
N(9, 2, 2):<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_disable();<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_UPPER_Raven2);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_LOWER_Raven2);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_UPPER_Raven2);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The PWR TSC clock frequency is 100MHz,=
 which sets 32-bit carry over<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * roughly every 42 seconds.<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hi_check !=3D clock_hi) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Ra=
ven2);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; clock_hi =3D hi_check;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preempt_enable();<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock =3D clock_lo | (clock_hi &lt;&lt; 3=
2ULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.gpu_clo=
ck_mutex);<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB515262B810158F1D3C6E8324E39B9DM4PR12MB5152namp_--
