Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0419CCA479
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A2010FC56;
	Sat, 16 Jul 2022 14:37:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACA910E05A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 20:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4L9WckVCazzhBR7IksAw1/b5ldhuCaPbn4uhcIJ5a2So/w/I4sa3rKJstgm5ZYY8gv5nxUyJQ5GOL93j3tuAZQ6CjhXwZz9a4dTZl3ZzkYYzIHZHLl1p/Z9LU2pkY8DabIeGRVk7cykht+eRp5w4ntti2OmInkBtMOHMbwxGwsG841cnzWzbQAchXlYxkob/om/R5jzye1ETQ//CmXCnqN1gTla4WbfvHGunrVrLBSBLM2Zuwq0vKkXF7p6TMz658bquQB7Sd1HZ1zLY0fiXSRW0cLThOkIns5stQaj0rxLqSAdkx1+xF7UB3SNRFrsDgUm1LxPEcKrw7NYEcSkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8iZYP9fU5SdAERyGjMrNDqXelll5MGU4jR2ctYwm8M=;
 b=TVIE0rI3Gzg3WS6KQ0ML63IckBprhHwwrE/uo2vjs1Kt3fDbmsChWsC3TpV/UljBwV72Bm4Cp7873Pb9kqMCvpKS8JRIK5rtpLOP29yOgbk/lVg4MfydEAZWMvnNkyUbcw6Nqj12B1D3RhfV1jUOsJWFQcRGavGVCowosCyd+ykrtwPZmLLXg7+IMnhBIdFPCy/NDh68cuNWJOgtaJNlRL1Vz31wy8LfixiYAVyY4kh5BwFvUdkP4Kt5S1U3FBNo7okQYoV8oy9tIXKG068zv+OrHLfuDSrT9E4NyKBnoNmDcoAteZ902HiCrEfAFcP7L+ICxytfRTbZ1F4GQmDYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8iZYP9fU5SdAERyGjMrNDqXelll5MGU4jR2ctYwm8M=;
 b=rZ8ITBhofPCD4kz7yE3w97EI4DBuwXMNWxk5eOVQXdXcPtYhuJ/NeyhiZ2efgxi0L3RSswebvL4uq7JDa3v/IpMuEFB+Govrdzr/RQ1/Ub6RmWvpV6oRnCbhmddxR0IFnkM+ZhArGsdMdrTDvyZisjSoJJwNP/luDc+ztz6udds=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MWHPR1201MB0207.namprd12.prod.outlook.com (2603:10b6:301:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 20:15:02 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f5d2:bde1:c504:efee]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f5d2:bde1:c504:efee%6]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 20:15:02 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Topic: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Index: AQHYmIYVFDP9vNlL8EuBYaP5/8/XtK1/3fmA
Date: Fri, 15 Jul 2022 20:15:02 +0000
Message-ID: <DM8PR12MB5399302BCB68C0717BE2DD0FE58B9@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20220715200410.301438-1-ruijing.dong@amd.com>
In-Reply-To: <20220715200410.301438-1-ruijing.dong@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5d97b9f5-52f1-42cf-a519-8452e55b1f34;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T20:14:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccb812f-1745-45e7-a125-08da669eb309
x-ms-traffictypediagnostic: MWHPR1201MB0207:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJF2sDfsO1c7T/6LMpPpPJAxqvBFxe+5Mr1rEMmfmf191LoE52z3Oyzdjsz7NRNO/vziQmaprWDcMpMHnXzpnnjHpCp2dnJQT1WGoNt+oTIWHvNxu48XkLi/J+1VJeatEqG6q8tbfsywHQSPjkmujCfWfjE+bEZTv0ZtxsIh7fc1a06NZx0qKNZNK1isCBQJGhxi5QfeNjg07FVcCBKuIMwrXqIlFav1yQaFvmILSHnlEFYYoa0qTS3GbHODyAJVLOXQQZW9UyVQ1s/n5lH/0UIOqO8BqPGQ2VvGTiQ6wvP1gdDgDT3lX9T+tj5gGbS06Ry5eJl/6Hin0HDJXj8CCA/RBD2zO/g0kGt0QoFQAW+gfGZMBJxPdGYjSU1r6ozfIhpDdbVjySHRoFaZpn79OW2jHn/oW4xKts+kQhUMA9mHW31ZewDrZ7Uxcuc5MxekHyg26FbTfXHjqAmHbr9unhdwM9TEPTG7EbMs1xgprg8+V4FW7P6QRHTGIQK5rlKnJEumJUX95lHRSLq8eBEideAHWKc+VjJ3bJOxRUyzS5CK7RoWl4ErmD/EUVzRXHLypBPKycL099Pmx8z9taZCY7G7dqPLb/Yq9IauGdkigpte0/067UEh6l/fnHFSWOJi/4Dg+LytcUrouRtcL6eVdqAc9ZgKXmNsiKP2kEgSS5metXdamB+Ywa1pFB3tKZB0R+x0NPyoUWQwRU981sX8cFQLzvgxCejhzWnOAzUTuXLdQmpWYgu2EVLbWtB50jMs58L/pvpnNiMh+7fm9uMKDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(55016003)(38070700005)(2906002)(186003)(966005)(478600001)(38100700002)(316002)(6506007)(53546011)(41300700001)(7696005)(66446008)(9686003)(110136005)(66556008)(5660300002)(83380400001)(71200400001)(26005)(86362001)(66476007)(8676002)(33656002)(64756008)(66946007)(52536014)(4326008)(122000001)(76116006)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?diB5hOh9qD/wOOGxg5vnUNt0iojPWfNl9t+PRU7vznB5zf2+WBbzJqWllmO5?=
 =?us-ascii?Q?IZySWnJb9vQJIBKOkV3BqwMT/xiD0zAqd71BoYpAEMcgnrVQ2E1qxnmNwDvg?=
 =?us-ascii?Q?tTmNKskY+2S1L1UWppiczPwbk4LDD8roc6ivKBClPGgYXUznsIzcH9z8y8lr?=
 =?us-ascii?Q?7alCfw8ZirnofI/dKBZNwckCRtsBSabRbg3k5owa8n9L8JUG0SRtDjnWNb3P?=
 =?us-ascii?Q?nCGOAjkbg0X1P7ovDDomjrfaPJAlBurb5cgjDF1AZlfpebKcO8/8gBaA3Jeg?=
 =?us-ascii?Q?jrcKAzmE5063NmUStVYiICynggm64uYX2+BY8rImKOqDkUwjkOEidzRbBa56?=
 =?us-ascii?Q?c+TG4hyGMQuZP74o8vrLa5u6v5XmNeOJnhU6AzxLEkI8rWhQvp0YEW8wjfnQ?=
 =?us-ascii?Q?CNF1kieE2z4nSYP7Rqjwb1Jn0Hx2+Tv1/pkFDM29+r8PynA6UMY0rxTTYMhY?=
 =?us-ascii?Q?DQL0VBs1qPjmQU7LvdlE/YcMyXKlVjAcw5DilyKkmVcRBoezhfDDOXPinpsJ?=
 =?us-ascii?Q?T/3wVzlaLjfvmMhOSxD01YLfxQJdj9gPtVGgEGE3botfeftvOkXDcvGiCcOg?=
 =?us-ascii?Q?H3cFzUbYhZdVW1MgkVJ1SMGQavTYfy6ym3ghc/UNiXymyqnqIY2L99jcmL4N?=
 =?us-ascii?Q?kqCKpwgAYGlHlw9yUDi71SptaFpZt8pAw0M9s1+unPXwI6bc+Mo+7p1xs9HV?=
 =?us-ascii?Q?Tf7UKFQb9x+JAaYSiPpLyqNk/nDc0hSF98O4SwTEVaxgWgzlOt5bgCZvpdf/?=
 =?us-ascii?Q?yxd9DUUift7vB5dv7p6CPGupaXwPItfsFlKDnxOF7HCgxYYVUeuDLs8pvhQW?=
 =?us-ascii?Q?GCGAAarqzNJ+iqWXzVLn/TzhMPMV0PXUphg8G3K9ygHGk7STyckl58eL7lpD?=
 =?us-ascii?Q?KBWH9JaBAMKyuWZT87G7i80Ar6jd4UVTxua3z4xgl1EBd7iPyru91gt24wRx?=
 =?us-ascii?Q?kIIfubgajK0QcM6jQh5uwArmFXaHcEDvgYpIQpeUCdQvFVScjS1uwMr+6OZq?=
 =?us-ascii?Q?+ZvRrgW8n+W92Cbr674Z7OCLlPizK82LqQzB+LLoOnTmYP+cqfVDEU7bLN2z?=
 =?us-ascii?Q?qfHcf7XS6M4JeGI/6K0NggdPQ6Sm0O7o8r4WGoF+zaPTJIyDnOe/owAORre3?=
 =?us-ascii?Q?RXwWp0Q6L4t/+a3XNjIZK95RbcPamday6zGQt6jPlxTKllux1rnoZQWJ/Hsr?=
 =?us-ascii?Q?uKbargfiX4wc54jtIbgnoG2HIoJZiwershmpH1CQtffteO8ZMH3IBnGPpeUe?=
 =?us-ascii?Q?DnkrVrZqMOkViljQDPsusIEPXa7gWOHE/WjPGMqOW9AUNBrnh/I5qTNzRos+?=
 =?us-ascii?Q?ZggwlQCehxs06Xm/f3lssoRd1VCFE2qrN89iVjpU0OSkdOlCQxgDfNdavFbk?=
 =?us-ascii?Q?Ex+i/cBhWcZNOjP9vwWfxjsBrZVVCrBMbantqLOyu3hlbk4miY5sPaeVj9Ks?=
 =?us-ascii?Q?BNOeFGN9TmqrqGBQPM3sXnWCmEmQ90mjb0u/A7kkxhbJMX0oJKIEshQ3vF8a?=
 =?us-ascii?Q?YEoJ/XHtrNzPUis3B749k/wBi6HxC0H5CkV4madj3pWKwoTJgOnm0C3EE8nG?=
 =?us-ascii?Q?5vFX9vdpAJ/QHAYS+Gc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccb812f-1745-45e7-a125-08da669eb309
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 20:15:02.0340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkk2Zb37J3+huoY40T7wXoyjCl40yHiOAEQP6nsOnwsNmu8kbe23IsIK8x/SSk7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0207
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: Dong, Ruijing <Ruijing.Dong@amd.com>
Sent: July 15, 2022 4:04 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Dong, Ruijing <Ruijing.Dong@amd.com>
Subject: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type

From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support both encoding and de=
coding jobs, it re-uses the same queue number of AMDGPU_HW_IP_VCN_ENC.

link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index 18d3246d636e..e268cd3cdb12 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -560,6 +560,12 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
 #define AMDGPU_HW_IP_VCN_ENC      7
+/**
+ * From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
+ * both encoding and decoding jobs, it re-uses the same
+ * queue number of AMDGPU_HW_IP_VCN_ENC.
+ */
+#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9

--
2.25.1

