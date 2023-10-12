Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E9CCDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 09:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D1D10E46E;
	Thu, 12 Oct 2023 09:18:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115DF10E061
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 09:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdCNe/mnsEHNSi4LZ77MoUvz+JD7EwocTE5Z7VOXyUBRYtHaiCK2FiVzBgQv85W7o/kMMV0E0HQyqTfb08U7zTRZTQN1PMILHZcj0KFlQqi/njYpACYJdIX2fXbF13iGjkbj8EZdB/vwHUecDrggPF9Z4IKkpN7SnJzemFxvMqCpF/8YsKWpNeUfSMTFknHLaqve4lEa4Hcvwkyk0IDGuKDfNCw/67cxzFGRjJR0H476FknSxZ8I0RtrAKpGHLQfemhPr8WQPEGZBg33AqxRUAw1vgguYY7EhldgGlFF2daAfYTpk2VfA0dDVqXx0DLGnCGK4HghfjZGCYDmoJvgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7H3zUfrDcOxvWAn3Vx8UI6fDS8DL270h2aEXLvOne0=;
 b=GizzY3cCwVeElC447qACm570Hxpk4oQ3VgMEGtbcEBIA3y5dgRbyZ83VFcqT7APZRchouvjl+LW5eukMPMqBXA5NnJUSwuPDYGAGJqtAmnZdZZNmfSNHUZCR4KzjUyVar+T1ceA4Rasf71D7aPuBoo+55RCzq3UXeXk94LsUHteLgAv1LYdBA8mjUR6nNcr4XJ4oZc959Q8/hN+IQB4w1f6DPEGKqPTpc0P1E0Ip/I2Vm2DKO1i4DA6GDw+tELKXc0+YKVNAI2ByVngfrIY80Pb6b62IYwK2f5lYgPKtvXEYnnlg9p9sApjBbz2TNKoeOfz2uxAYZnMsmOQjrSs1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7H3zUfrDcOxvWAn3Vx8UI6fDS8DL270h2aEXLvOne0=;
 b=uvuhGFkZFB5bCJBzWFX/lsESm0kYqD5qGwYiq33X3g9xC7rZE1WQ5FJfQC5dAQmJuWyIU/sbgIdR8mNQUaw39z6R6qrhMdbD9+1fonEJXM+0Yf5OVBq/hvLW0/JR7s0ea6cS+U9v/RadI55LWSd23SBx6j+TWLFd5o6d4tdxhhg=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:18:40 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::a0ff:9646:e28a:eaa]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::a0ff:9646:e28a:eaa%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 09:18:39 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/umsch: fix missing stuff during rebase
Thread-Topic: [PATCH 2/2] drm/amdgpu/umsch: fix missing stuff during rebase
Thread-Index: AQHZ/N6peaDo6N4c5UeLDXwM8TQfa7BF4FMA
Date: Thu, 12 Oct 2023 09:18:39 +0000
Message-ID: <BYAPR12MB2693A951BD5D538865F605CEFAD3A@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20231012073506.1076224-1-Lang.Yu@amd.com>
 <20231012073506.1076224-2-Lang.Yu@amd.com>
In-Reply-To: <20231012073506.1076224-2-Lang.Yu@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d2bb8698-b353-4266-8e2b-f7235ff519f0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T09:18:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2693:EE_|SJ0PR12MB7082:EE_
x-ms-office365-filtering-correlation-id: b05ab3a5-cd00-4040-a1ef-08dbcb0438b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 821m/cu6nZ0GViB8TA9AukH+bqrk49zCti0rB0nsc2nUqFx0V4iPUDd+nqPBL5jRHIzy3822RbOrSR+GJ0s6IFjwWGfPqP3KQkCIMSLmD1+bbrJvRGwLgRpdB+udWwsfbKaZ0yBLgcX/l6hG2slXxzzdJlCHxpDMR5KoGDvQt81Wa8Zt464XG/bXVvs/gQ9fEWLFR5dByST+IQqXvMPuwOxvCUjZupFpVhQ7vUVqQSPK/Le41wB5ghrL3OgF/mYbN5LzCY1WOgTD6+xVKU3rYURVb0XKjPWijffUxGIdFydYc38lM1CZTMz9H1iL1aQOtDaS4JjojpViHMx2TCkk9VtIzO3KTN6qevQHejf/7Py/RAwnGc1+9DyVYC1SSljh8krPcHPtXKi7S32eUbdRH5r0uBnfm2TutmMOX4fl5KnBTml8Y8u0t28znaC5poKKh2nmzd0s5eSiOIa6nHyUoLZD7kBP7kQOSt681tgYW063/1ltWN7vBAfyoHktR+pbeSYLDEP61XPOzqC/9BCQt9dTRdeNQjdCaY1dbuDPa0uzt+X+0mfVtZUkB8mfvkEgJB7fxzdFXmwjTH+QVboh+vu/1MrwWIQ5FLW6Why9RDg7asHgDnc8xg86veto3iKH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(8676002)(5660300002)(8936002)(83380400001)(41300700001)(316002)(76116006)(66946007)(64756008)(110136005)(66446008)(66476007)(66556008)(4326008)(52536014)(478600001)(71200400001)(7696005)(6506007)(9686003)(55016003)(26005)(53546011)(122000001)(38070700005)(38100700002)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4g7agf4sjix2EddgMXU45Tscb02pEeEeQ7Dwd7oRrVMvebDDcWdQNgJLm3F8?=
 =?us-ascii?Q?jsf2CWMGI2cJG7uxXLRKVUeH8iUxWC3toSuB75geZiEw1IOn4UR5k/j+QAF4?=
 =?us-ascii?Q?r2SeatK+5e3X+MaNOGQ7eKrAuzSzPs5+zyHLp5Vyaz8rwTiMqIqfHu2hOJH8?=
 =?us-ascii?Q?UgS6sfufln9yhMHGcufpI1bRDoRfmyoMHyMTyQZe3lhFfI7N3kGx/AEaPmH0?=
 =?us-ascii?Q?XADYQ2GWyRperStTen7jm38fV22r9dN4JWixdrpswohMdKHXLB22BQc/qRmt?=
 =?us-ascii?Q?Xkvi6Tvw3hS8/5Hog0nPR8Un1v1nQUPncTIjxwsPK+pFU1Z19F68DHrzIlF8?=
 =?us-ascii?Q?P+Qx7lmimJURRp+StzhDLJ0LvCMKaddMdVuEYuWJ0f6Uvsaga9G0B4wENNRc?=
 =?us-ascii?Q?eWRaowMx2Zp/EeIVwlMnKR1DbFxYSNGiu4YqIuvR71NjSwYBR+Ini838h9wh?=
 =?us-ascii?Q?tn5krso65Saom1b41Bus+YVVJfYEDF6JzoE4wkiAWekCBhYasUsF5L+oEN6I?=
 =?us-ascii?Q?F+9hCV3Bi2oPmTv34EVsEg9o1YE41wqCSk992qszHv60SRbRhkKX/Og5y1tM?=
 =?us-ascii?Q?IjpyI/qKn/dernSv5QdDl4gwSPhwK59/OYHdcGjnGSpy/fM07XzONJCzSRbq?=
 =?us-ascii?Q?N3YWXwJy2KIb4f1EDyVvKqOu3R0Dnyq+P4aXmn2S1/p1+CkJjX93yFIEZJ4V?=
 =?us-ascii?Q?R+BpG0Ska9eM9COpLnpNuBgoTxAgS4WKjkZ1JIounIfaozeVa3RtXSpS4d7I?=
 =?us-ascii?Q?nRcPPXQ8iF/InwTfVFT6JYIS74S/ODAK0oioZ1PaBf17BfjcaXOI9wJ500Km?=
 =?us-ascii?Q?0DA71OfoUMaieypkE5RAcVPibJ+1gAmoiFtaQBBZPQAmUEwyoCVCaX35rsuN?=
 =?us-ascii?Q?9xLmad1PP82G8I/X/3WZcdCQ4zE+K4+skMjNtoU3CIMM7aH+CiOIqoqcjXQp?=
 =?us-ascii?Q?0K6w3NaqXb1s7S/qH19YcXbjGbnOeeVUxJG1kUQs03Ah7i0lp1IB7aMfzjfp?=
 =?us-ascii?Q?RKmFirSBkFqKI6UEyahMcqjWQNCHB7HVt07TQSYR0iFCCO0QmlnkFdLooOZ5?=
 =?us-ascii?Q?53GDKvo7fUBn9twTmWp9Rd9kFvy+lid0mgeWCJl3969PwJgjQso7s/KAu+lB?=
 =?us-ascii?Q?eAOToRhZnEA8xxofaNM95SHTJa7bu+YSOsJiZKhCZwDvUhcHXmUlPULwr9Pi?=
 =?us-ascii?Q?21rwFtLQTcjI8Gt8YkwUzeuI6O3WZ/FBUnHuVvjTMioqCMlKUDCMoUnVnjYI?=
 =?us-ascii?Q?ChXVXBnuWWpF84/hPeUfxRrSsaSUm0QyXZUtBZNjhZcZ+yGsR3Szw6lMJebs?=
 =?us-ascii?Q?4oXH7aninb5kyCilu0PJ8j/wCTkLV2zTRPgMDDO3uRXn1ngvC93Cu469odtF?=
 =?us-ascii?Q?/qpr0lbUC44ZoPZiMKXkpkmxAHav4BMqMMtq4pnFzxuIvMD8g9fVHzZrXNWH?=
 =?us-ascii?Q?eBt8s9nAr5uwlelxlOaPwOIymHT7ETXxt7ZFNyEBgRZEEIqcggbhm0eCmX8V?=
 =?us-ascii?Q?+joKFBPV6ePuNXueIK0CcmriljEXyvzKH4S9nj+ecRs96u/Xxkoe6zDCmBun?=
 =?us-ascii?Q?fbuRNDcj5RD1BYF+YSI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05ab3a5-cd00-4040-a1ef-08dbcb0438b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 09:18:39.4828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gA0Aq1JxFzJcPpXTV8F/WSxFjudHr1h9Brrk4UBalxaCg4KMQGro+7MBVRWYJd1JDdA2X/s0F4IjbtVeckMj0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopala=
krishnan@amd.com>

-Veera

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, October 12, 2023 1:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan, Veeraba=
dhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.=
com>
Subject: [PATCH 2/2] drm/amdgpu/umsch: fix missing stuff during rebase

These are missed during rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 771ef8017a98..3713d0749813 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -674,6 +674,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucod=
e_id)
                return "UMSCH_MM_UCODE";
        case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
                return "UMSCH_MM_DATA";
+       case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
+               return "UMSCH_MM_CMD_BUFFER";
        default:
                return "UNKNOWN UCODE";
        }
@@ -806,6 +808,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_de=
vice *adev,
        sdma_hdr =3D (const struct sdma_firmware_header_v2_0 *)ucode->fw->d=
ata;
        imu_hdr =3D (const struct imu_firmware_header_v1_0 *)ucode->fw->dat=
a;
        vpe_hdr =3D (const struct vpe_firmware_header_v1_0 *)ucode->fw->dat=
a;
+       umsch_mm_hdr =3D (const struct umsch_mm_firmware_header_v1_0 *)ucod=
e->fw->data;

        if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                switch (ucode->ucode_id) {
--
2.25.1

