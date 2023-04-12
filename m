Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BD8C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 08:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B54F10E73B;
	Wed, 12 Apr 2023 08:31:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6BE10E738
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 08:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQJZqKPdFad/rQb8lHh4uLosSIAAAKe/skHXhZX0XPVDPCn4dmrCvBSbIl7YHmg6qOTES/N3/6axQAEBo+EnsgLnl9+vhy6FJbACjhCFh5rnJrQz5g6DJbY94vnxScktq5MeZ9gPM+OrVrrgDu2RfIodZkGkH1ewokBXJStfYlkGCnmtoSrYsjPD3fzCbdtfAAXViqhvXaCwQAg+F8P1w6upZN6yRX77/Gdvspgcajul1lduQbgNsypTZ9a3PrfTeQuiqQXBTGXoh72y0QlwAiNaR0dmxIxIiwzO56hlPLF3PgWOUGXE64KQK89GCwJxIkj5+aLW0IrrZ6UID4hLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaX6qO2rcnm6cet05CTIxSsi2bxtnA/rK3YXPdGR/dk=;
 b=QAWde6javubFc1cwpTKs61oZ+XSk98G91CTLM/FDbH5ZACNbl5SXCU9sA1MjpuUiLgMqLLQfrragwQ0kfVksoYo9u6S2K9EL4u7QVRIUiTEWqcsH1cq9W5nmdwzBbBCOMiq+FHj/0pnilNILgjffUEVK1mxaWssNpe7HL/xHAO3Ksy8DxGGew+Nsvnl4fjKRqzCjrLVWQiQDZSI784AtXqGbZYM/guLl3ve0jpXOHysKE9EChHRycIPunjW+d49u53OJs6u0NCkt9zrQKrO/yeZny8djA7+pffOYOanP2gb/+//f4+foAoj8KhG7aQ+pkNSqG2zTBxo2AmbdTw3+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaX6qO2rcnm6cet05CTIxSsi2bxtnA/rK3YXPdGR/dk=;
 b=XQhNPSaOJEZ86i4odjsNqqRPK+A9HPjS2bSxgQUCsjIbJNK9hMeJoHjfuHIWRR9c9Ly7DAuf05dfotvaQ9NVaxa7LY69+3JT/xodD96/Lwu2syn8fcOnuuJGeleN1Woa7ZI/s/Zsq4nSgjotjLhK37QLcQ1debnybKgvhjjbrGM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 08:31:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f005:3ff3:4f85:d51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f005:3ff3:4f85:d51c%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 08:31:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: drm/amdgpu/gfx9: switch to golden tsc registers for raven/raven2
Thread-Topic: drm/amdgpu/gfx9: switch to golden tsc registers for raven/raven2
Thread-Index: Adls3RpnQ/cq4B8wTZCxajUc9u46LgAPA8zQ
Date: Wed, 12 Apr 2023 08:31:43 +0000
Message-ID: <DM6PR12MB2619340A18FC0FE1A304488BE49B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <DM4PR12MB515262B810158F1D3C6E8324E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515262B810158F1D3C6E8324E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-12T08:31:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=92f783d2-82c1-4720-b37d-d74262cb2702;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SJ2PR12MB8133:EE_
x-ms-office365-filtering-correlation-id: ee3bd8f4-baba-462d-8b27-08db3b3058d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hHVc2cBVGNsQQQSwUjcXMCdE+ofIcz3LoPdpykN9X5ku+3ioQ9nLI+/fj6d75stQMk6EE+wDTImzm4t8EWyWUZsFDyk2lYuUWFUQ7b5jr77hRuns7q0gp6WHlc2Svs/emqaJ82NYqd8ZlesUwmvuPODvtvmWLkfuCMnUUwJmF91w4ugDoS6pLVa2SD2lplDmGBf8LjiLm8RCa2LdN9fWAaFHtXfBaP4ncFXlKvLRniLvXHqmkg4GgADv6zf0+/KBKVBwisbJ1vxKFFkqZC7iYQCQZV1ACowQR0jcRwiIuSlocfQWdUO8l7i2gg5KgMMJmoGuLjW9t9Q7DsjOWXf6jwSWawBAzoHBDUHelADTsdcELa99pImoJuKtLnSaIbOsGWtAN2BWk8na5qs567E/C8eNaGVia1BnWuz/EpNMEnQEirqGhMlScrc4Itd6mQ+B7zoVQAX4QvkTchzJUnEHzLu9Ry4X8zWWdo01HTX9lVPUPnSB76YqINyMvQXwC5+YtcULcWnhSE/SVkg90iFrT2FEaDNXMohI8+G/tq5m+4sCfg21xhcRHTOXhjCPLCbOXB7Ew2ewLO6IhROZ+XozVjfvkuDg4bCz9+mb54Jt9Uv0rtloOPCTzwt7Mqn4lfPo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(52536014)(8936002)(5660300002)(38070700005)(41300700001)(7696005)(33656002)(86362001)(478600001)(19627235002)(6636002)(110136005)(8676002)(66446008)(66556008)(66476007)(64756008)(71200400001)(76116006)(55016003)(316002)(83380400001)(66946007)(186003)(2906002)(38100700002)(122000001)(6506007)(9686003)(26005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?87pzs8hxXa64qGTGiwYvn7xQfSdL0wSWFixW9GO0JSjN6dRGuA532DmYBROP?=
 =?us-ascii?Q?MjyK56JYPh9QaWEXehGLdpFiHYH4+VpsSkR0bun72ICr2ufgszr2FxpmV9XQ?=
 =?us-ascii?Q?qgeYgbYjlb9mKqjAmK4ZnC5bp2m7PAfKZIAa1PYOOkl4pYm8YAGbiiwrKWuj?=
 =?us-ascii?Q?ngZjllfsil6OqsoCwGayZ67i1jcDgJZLpoiUCfzbnCkiaiguJbs7NE9BiUA7?=
 =?us-ascii?Q?AQOwQFWSZl5T2QoLxh+0FJv1og1L8A8xi3GRNsJs31zX2A9ZkDaMNVB2fn9Z?=
 =?us-ascii?Q?0vrwEHxIIoFrYMzyX0FO5+E9l8g8xkZsyYkn9gu9IxDQV2g9AD+jKnq23b4w?=
 =?us-ascii?Q?qt1uzN3jiw/m1mhnVjDl9TnFjMuuRU5gIzephTrerF5HXtSvp6knSYzg0tSp?=
 =?us-ascii?Q?mfcw7hWvQmXPFDU4FQq6eo5fBJmxRUghQZbozAGg0crk7jcX90jL6RbNfkpC?=
 =?us-ascii?Q?ZdyIfC1Ebvno/XoLYxCYRYLwwlX1wTeoJTiv/0rgdCE6w1fmch4CAKvV7oAV?=
 =?us-ascii?Q?uE1NO/1Li+/YaKI87QT3bK0z0h45IqI5LJpKI+g3TnkXQvgDaxyQtePJrrnT?=
 =?us-ascii?Q?rAwvkZvTfNG5BxnutOmNUWwQeHYlozaG+lVNSgPEhUq0+dK+pXwOOvXRvQ3f?=
 =?us-ascii?Q?AzgeAalST8dFqggHDUgIAe8aLL9UEC72sXYPn1vXY0xDggIPgHb4QXvsHck7?=
 =?us-ascii?Q?WNusZn97aJQYIi30CoJSm/yX+SjNuMFNgL2hf867AGEhgl6zmJCPg8z19Zy3?=
 =?us-ascii?Q?DnJw4C6CugmkfNN56npw+WddQkL2mkVI830P8kPWVSnOd1ZLWtNnzWBkAI+X?=
 =?us-ascii?Q?tg+2xojVnyRQRLxATQdwVYJRzoOG6g1fQ7ZdWiqpF2DvTDALw9vz2chkA2GC?=
 =?us-ascii?Q?+ZdmMdG6leb5xWGsM7T7It25fdwG/c2lofSyOQIyfThGOhAbE/N9I3mk+lGw?=
 =?us-ascii?Q?fcaQOqgJlKjbMzx4kfttxslyuLyPslWGWY3/yOtOVvk4Ub8s9rqC2Vk+mX6w?=
 =?us-ascii?Q?7BmC7zo7nZXoSSqREooemOVcmvsfnlErBqaBkknEztY6GCUP+oC68LElrOHX?=
 =?us-ascii?Q?LEBhmkRiBV49qLqAly2bjkfcryvz9Auf1zAg4JT68tB35QEPbSEEdbhWOKtZ?=
 =?us-ascii?Q?/SrMFzqlPNccC222UVUtWRBkGROqRtg1S153AehFgLD8V9itr+CyztVVROND?=
 =?us-ascii?Q?8Jbl1K/UtMkYfxXlshRf2qG5LlKB3IoQHk8qopctuK9WXVJ5vkiwCbjxRJFb?=
 =?us-ascii?Q?UWSjPcBqtNxWxnQx3VVaQuMT71DXvRIN0wvf0SMuNlgktWZOOBZiSKZlcr+r?=
 =?us-ascii?Q?aHLiuaRfpJh1m6uNRUgOqwC1h2S4JpQEGyzFRNpjZJzW+M/X+j0D+LJvW3Ka?=
 =?us-ascii?Q?GtX/qBZMtLq5ew6q3s9ly5gpwD7KCq5pojhhP12HOLdKaHGr1zIJlZ7B/FK+?=
 =?us-ascii?Q?gMgFnsPgS50P3ZiisYjHbH83SXUzohK190zqJLG+3VqVCSN1AMrnzfkFVgaG?=
 =?us-ascii?Q?ggJyYSHD12xiNgAaLQ6ZmAmlRJ/i4s5L48H1BetfRQoYkKqI8OYBuFaFVbRK?=
 =?us-ascii?Q?zgMsrn4hI5CMKr+yMMQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619340A18FC0FE1A304488BE49B9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3bd8f4-baba-462d-8b27-08db3b3058d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 08:31:43.7347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U05/liK7Np/ejvDX7hHGMtEZE2wlkbLvLPJI41gt/UfAKrreBWvyAsuMSR/SGxHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

--_000_DM6PR12MB2619340A18FC0FE1A304488BE49B9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Better to update the patch title with prefix as "drm/amdgpu:" instead of "d=
rm/amdgpu/gfx9:".
Either way, the patch is Reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Wednesday, April 12, 2023 9:24 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Quan, Evan <Evan.Quan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: drm/amdgpu/gfx9: switch to golden tsc registers for raven/raven2


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

--_000_DM6PR12MB2619340A18FC0FE1A304488BE49B9DM6PR12MB2619namp_
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Better to update the patch title with prefix as &#82=
20;drm/amdgpu:&#8221; instead of &#8220;drm/amdgpu/gfx9:&#8221;.<o:p></o:p>=
</p>
<p class=3D"MsoNormal">Either way, the patch is Reviewed-by: Evan Quan &lt;=
evan.quan@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.c=
om&gt; <br>
<b>Sent:</b> Wednesday, April 12, 2023 9:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Zhang, Yifan &lt=
;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> drm/amdgpu/gfx9: switch to golden tsc registers for raven/r=
aven2<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp; Due to raven/raven2 maybe enable&nbsp; sclk s=
low down,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; they cannot get clock count by th=
e RLC at the auto level of dpm performance.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; So switch to golden tsc register.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;Signed-off-by: Jesse Zhang &=
lt;<a href=3D"mailto:Jesse.Zhang@amd.com">Jesse.Zhang@amd.com</a>&gt;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Evan Quan &lt;<a h=
ref=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
</div>
</body>
</html>

--_000_DM6PR12MB2619340A18FC0FE1A304488BE49B9DM6PR12MB2619namp_--
