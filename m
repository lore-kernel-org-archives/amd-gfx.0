Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4D0E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CFF10E27A;
	Mon,  9 Oct 2023 15:05:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC70E10E27A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al8ARA2xgaxjXgbi1zqP5bNLLlHRKDob4m46YBaVLxrsxIckp8vDnJX9nq2KdqBPdT33053ayTm57pSX1PKQcSge3ZkZM9Ebuukq3gBSe0ZIUrBYI6Ge2tk9QHIT5NkSizW4ziNzeCy1nUSlQPyE0lE7iPtf0UEiCPYdIapcm9o7W6tbQpGk0leBbwhes7V9KXlxzR8fFA0N8+qKKk4Z7so5/6N7pkMz9JAtN01g9MJPvCZ44lxPpfbf8ggxVzT2QQ6tW88BExpf1WwsMIsJ/JmnBC43QobFz+qD8tuf79/a4f2UeXTyRYbZKGDNXO026Y5QmI2qRe9U/xZYpB4viA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnG+LYwa9znShzvPJo+CiutGiJoj+nZxSKWljqPKiKc=;
 b=gSHITqo6W/aFyqmzhDoODvpMz2wj9l6t6uRemyFT7ZH+TDrQGhoOAdtxi9jc8QOT9zIt3VAWkt6GQUkUxmJbOiqX520jmdV2SJmPARMrHKxRtTFEHpIy/t/eFMvV0cJszUcE08ChQ7uljRoBFUMutxFt40Pes6YSd8ZXN0dKd4/1jja+aqNaCXXubqVtW4OkEEvU39fu8ZKIv2fVWy/j25VzK4jOEoRfVfCLoMDZ7V2c4li6CwJLQ1re3wtcKSKsrgbIRvVnuY4pqMZMYMPBXiuPda9rYpl9rbqzaE/Yw188IiOnAK5nfjFsjWOD8E6vAxDgQqTgWJ3Cjx5dv44P+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnG+LYwa9znShzvPJo+CiutGiJoj+nZxSKWljqPKiKc=;
 b=rONWDyiGxl0zhPvGPgHDlUvZtdyspvqqLWa4easSBaCPqKkq1RE+O2NesNedbM+gkzEwUi2xTR20rtxSEbdSkwjX9pxvZrTewEAl1cgdMZqdWT29FX8rap0ADDdvQHDIevxv32VTojRRM7ysIn0ZSljpqNElW2m2SIMGTYr3Gp8=
Received: from DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) by
 BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:05:37 +0000
Received: from DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::82a:c688:3c6:ee34]) by DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::82a:c688:3c6:ee34%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:05:37 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Thread-Topic: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
Thread-Index: AQHZ+PveGzB1yfYdUk2ygF8nZJnKOrBBkhZQ
Date: Mon, 9 Oct 2023 15:05:37 +0000
Message-ID: <DM6PR12MB2697F5A24C664A3B9FB907F4FACEA@DM6PR12MB2697.namprd12.prod.outlook.com>
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
In-Reply-To: <20231007085402.67350-2-Lang.Yu@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7a933d9-9d85-44b6-adf3-62c2063be72c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T15:05:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2697:EE_|BY5PR12MB4885:EE_
x-ms-office365-filtering-correlation-id: 92bf6fd6-6473-448f-af1c-08dbc8d93207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGr+b6R4wYt3fva5q2j2idO7XaT1zbkXqpO/13itkG4zTpfZwrO07i2MGQ9yyNRYzkJu28qXXUECjLt3DS144ei9Yms66lmNRIZHAIv79SIylG48gQ/jYrbWSzPZTuH8X87REhmhlmC/eefsINQpz1SSTHRpCXOabinUsJfwtP4nFoTJ5h911+TW74pfOIdJ2X+v6gYb2O3k65xGe/aUrqjTN4/F2x5r2ftjSefmIstpa+FscuSnU9TyzDmrxUENiK9MJG5XZByj26/hN8JOu04VUeTunLQPVR8Rfg/VIq4uusO7qRsmMbnDvIkdbshqB+9Lq1OpZKMAMLBdEqvsWjxw70pX9ljsEIuzlaGQqoe6HDExipo9bW4qmx9aDSGXXACo6+w2+X1XbDgAakbRC8S0ntIzQgMa2kqSmJh7Pm4U3LJfUifsf0uaEeMexr21Hh806vQOt8uXDe/gOo/ooKdOeLJUC22iQ0SOoNj6Vw+HEl+Uzi/xQC/cOLQucnFwbiEu2ilzBqzbPDtGU/3ADDA6kpKvp6HarwJbLnnZzjYZUZF3500hOMH4FqhPAz8tmvUvVSdbquHqTaJOdT1656Jt6Nelu0iDTHrwBj1VXCpFvanDDdvkmkhqodfN/Rpt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(38070700005)(33656002)(122000001)(55016003)(2906002)(53546011)(9686003)(478600001)(41300700001)(52536014)(71200400001)(5660300002)(8936002)(8676002)(7696005)(4326008)(83380400001)(6506007)(66476007)(64756008)(66556008)(66446008)(76116006)(54906003)(110136005)(66946007)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DjRDbA8rrZzYo/9xOSLnyvaQvyBxY8Z+FCOPt3IpMx2E4woXoCfo1/16Ec1y?=
 =?us-ascii?Q?2govFwCx93IX5RxIshbuDxvn4GntABccEoKdiJDAb92RjHdSWmPJT7kbY2bS?=
 =?us-ascii?Q?HQ65Xp/KED7mwW38jY3lJtO5BNc3S53/fSlGb7or7xHSYEGy0uQNMg5AHBoo?=
 =?us-ascii?Q?1KFc36nmgbUMXxCmRGx4WEQfsnw8B7yX1KVMtdwaVcWTmXPxYl8HrEZXTzms?=
 =?us-ascii?Q?YhPRqs+1SMfrQM0+LcirT723XKgy/DSDifOBmxaLjcE1qLWA4frP+HI1JN0i?=
 =?us-ascii?Q?ZPvc8uu5iYX0MdOeZllYOUr39rAVG78dS7UTNupzP3KHr+Iy6JL8VGJOevx+?=
 =?us-ascii?Q?MpZFEFMEekbN3mNOhDJBqnrnrVdZ8tZ8j071yv2EPSBXPHRqdABhaCgrYkuo?=
 =?us-ascii?Q?n72z8ZSD9vBxs8lqM4GX7SiZNN7xwqmtNrg6igg1xK6JHCAnnoKmuOI56pGE?=
 =?us-ascii?Q?Xm/XpfUXJhJ15nCjMgVz2Rqe43sI6nl99KdQTGuoSgHiEfvzXzw6cyVJ8Bzq?=
 =?us-ascii?Q?IUuw+wNt+vYoZx4b9HIG3Wx1iht/2VwCgK1ekAxhF/JySHCeNnJA2V3OeS4N?=
 =?us-ascii?Q?v2MOP7mc9B6JZ6rml1OCsIZSCtqJJPhnxQBppOP+qlf+5Sbs9yqKwhL9Zpm0?=
 =?us-ascii?Q?x9b5GFbMWtvmoiv6+BrTUmjR4wiss+jVSk7t6S3Lz8+PAALK6etOR++jC4eo?=
 =?us-ascii?Q?KS64wt08WI6zQ6Uqk+DSKfOoEumCUwCpjBAjSHlDGtVqpaUUe0IVNG4ORLm+?=
 =?us-ascii?Q?Zgl4gsLRIOkQu+YeNHUH6T76Jz/o3DoIzk/RbGY4OCVUR3VuX+4HHk2bbuas?=
 =?us-ascii?Q?5LqRrQdyoK/wnT+u8IlwWR+a8AgJudagNq3vDlIJOcFe1cLg3bwy4f6WnWZd?=
 =?us-ascii?Q?k7KmA0+98MfT/s3Sk53SrXwbZeXxoL0K11LPUN+QRAvTzeQmtN0bU8uG6rzY?=
 =?us-ascii?Q?CfmhBxhBaqyu/vDilM69pLuG4ZTPyAedZWRi/JZZHfRA/5GZt1lETxYtyOFy?=
 =?us-ascii?Q?vgcGceooI+Dn1HNEdQf9tTCbJnQx9mS57Y+9BaPof9yRtarXnsJ46nteGDab?=
 =?us-ascii?Q?Q8Hw+m30lPrpggzOlJP8mjYFtgggWshu9S3aLxWZqSoNnABXAVYvs9M7n7TA?=
 =?us-ascii?Q?Ipn0EtFPSwVCyiwg4aJaDAWYPu9dDXbNpbTup4rMumVruUfC4RXgOeg9AMJL?=
 =?us-ascii?Q?ZhQfu+nHXlwFGo9Q+8LibAdtsGOZcmF3oNjo3Ma9yKi7IH15MoCp4fkNb7hn?=
 =?us-ascii?Q?vh7cw7Z9yy6GluaLD0KhH2MJgW1PsaQTZ6l3LN8WQQrtgiuWD2HwoDTWmUk2?=
 =?us-ascii?Q?NYi8XiStzcYgAuVawT4MGUxWjzYO4SFasPRpZ/GbtELgPH58xSgBthcaqZE6?=
 =?us-ascii?Q?y927gm9YnWsK0AAwlHUJ+at81dJJFEb3SEJcmBigOI1FKgafI3X+iIzOf6Nm?=
 =?us-ascii?Q?q4P+CgFE7dThfcBAePjSVuiRAzwL7uyzYMWj8CRnSMk2WOzaQoUNg7PL0ZoK?=
 =?us-ascii?Q?LXSz0m0a6dxNRWNSxrq0QwWPJlly6K9lWZERlR8wrWJ7cvpHIsXOKz19aqoY?=
 =?us-ascii?Q?cv8YqPhmhDL7b4OWag8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bf6fd6-6473-448f-af1c-08dbc8d93207
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 15:05:37.5667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +onvuRE9/Hcvfrqk9UJCPdHEPluvgOqaxyGjzY7zvTaieE3OJtcbhTa83yGMNjEhca7sxADMFQ4fPimE+pUXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

-Veera

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Saturday, October 7, 2023 2:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakris=
hnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO

VCN 4.0.5 uses DLDO.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c
index a60178156c77..7e79954c833b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -34,6 +34,16 @@
 #include "umsch_mm_4_0_api_def.h"
 #include "umsch_mm_v4_0.h"

+#define regUVD_IPX_DLDO_CONFIG                             0x0064
+#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
+#define regUVD_IPX_DLDO_STATUS                             0x0065
+#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
+
+#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT        0x00000002
+#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK          0x0000000cUL
+#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT        0x00000001
+#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK          0x00000002UL
+
 static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)  {
        struct amdgpu_device *adev =3D umsch->ring.adev; @@ -50,6 +60,14 @@=
 static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)

        umsch->cmd_buf_curr_ptr =3D umsch->cmd_buf_ptr;

+       if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) {
+               WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
+                       1 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
+               SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
+                       0 << UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
+                       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
+       }
+
        data =3D RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
        data =3D REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL, MES_CORE_SOFT_RE=
SET, 0);
        WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data); @@ -229,6 +247,1=
4 @@ static int umsch_mm_v4_0_ring_stop(struct amdgpu_umsch_mm *umsch)
        data =3D REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
        WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);

+       if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) {
+               WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
+                       2 << UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
+               SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
+                       1 << UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
+                       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
+       }
+
        return 0;
 }

--
2.25.1

