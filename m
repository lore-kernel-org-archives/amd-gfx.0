Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF28CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 06:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E372D10E6F0;
	Fri, 18 Nov 2022 06:50:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28DA10E6F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 06:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkWOJBU74mG9RARUGLqF5t8ZiXw7SASoIAZs9sdT1tS5MsFkndXd10DHxZeSZ9hV1gu2rxRoG8dTDFPeG3h+77aKVgBh5LXWx1f9MuW4jV5wiDYUBkhll52rGmPSC9qvphEFEczEozijP755DEVjxzd94BVVXZB6ZXtU0bt8BzJtIDEEXA0RdBY7mxJmIbkxPV7DYQSk8bZngEEhq/F4aIahyKf3YA4wMgwK/SX/hYH0+2//hLyD31Vk3pN/Nl4yWyHuNLv1b9JvRSyAuP0jfORScdhe0AWt0TTmL3WASY6yu1m+0iXVa95u9pk258hgFLgbGC9eAJG4RW/X8JK9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCNRFr1pDuSclkOK3YZr/4Sgi0w1MRO1F2z4Th4GXqQ=;
 b=li/6fJYdlg5PQCzdrpQ+L9MNA46suCdaDdewgy2jjWmxIRCRJmfnJpAONUncjmwYIjYr/LXoCVmm4Qjiq75bVGggDNjQLgLNM3W42IAf7yo/obBg09ikHfEGjSV8mUStMXJY8+/J3grTF+DMOA82uNbLWSrqe+/t3XgbJdwuLc0WNxOBEErtuFwPP4kSe+/bWC5kRLE5yM3Dde4FWDyD02vI/MkNEIdB2Vb1iEkKESrMbLgGVOqvmoaFeOx04TZfKGAi9LZGerPMGb8+D78oIcQ7jclKzG5i5J1+LljtL5SFy73FHuBu2KtNuUWq0mUsEkzRtfeTxDZWrhImvvYd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCNRFr1pDuSclkOK3YZr/4Sgi0w1MRO1F2z4Th4GXqQ=;
 b=REDZ/5+ruiHgsU2dClp444WVxidTH+6LpJMA41M8SuFJ1VsThIdiE3ux7+hFeQmmonSPrkRhy6aEacq+Inh4H665mXR4CzzSAXtqPdBTbXYkE92Dn5FpKSvKcXqdClgFnKq54UGqB0eX8pzxAvEq21ivyhR13vWIfkv5jU9q/0s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 06:50:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677%8]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 06:50:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for
 firmware
Thread-Topic: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for
 firmware
Thread-Index: AQHY+mTEAajZ+OSY5ES/h5hVezZmy65EP0+w
Date: Fri, 18 Nov 2022 06:50:52 +0000
Message-ID: <BN9PR12MB52574E994FED9A2339315F21FC099@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221117091119.106597-1-Jack.Xiao@amd.com>
In-Reply-To: <20221117091119.106597-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-18T06:50:50Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7c188546-2542-423e-97d8-d1110da9f125;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4051:EE_
x-ms-office365-filtering-correlation-id: e938a30b-317d-460b-720c-08dac9313c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Clsse34+eXSw7EH+IlBCaQUY/KNEkbwqCxSe6lE4Fiq/E1zV56gOutfAmetwndXYFFJkPY6zW49HwPTieMiylFVlPJvhun9ztbjBYzxotFgND+zKUn7yHqitzKOadzc9ogplkOI3kaxsJstgL2vt2mN9kdcba7hGe/GM7x/pe1vAPtBFep2JnS27quTCo98TE34s1o10qprAv3Vy2u0m7k+8MrW4Kr5GCnRjdE0EXAYiiDQ2w8IvaO5dddR0BpELS+MpIyiIm7X7Mp/0jbfWRun3ZsuBR0MxTNvYDll4ztb6RCtHwovq0MuWNUE3cyOZIxjtgXruarCXz3hG1lOrlhpTDkufsF9flH2FgzX4NhA1NTylA2VJfojaBJTdswav6qtLHJj6Xv6R5yGnBBy+lllE8/pLxoh2IeENHIviF0hjDdZrxAJy1eSdwN9DFkCO/a4lahvUn7nzvAY2+cUSUNR01u4f5HBjuMa0DW+HoPjAaV74xdpVCyT8s2Uk9+wf8GjfiTdfMCOAC0HanQIXuMtRmDLuTRhqUWHBVsb5ZMuHhQToVqcERFkmkbxBPCo8AyXnmE5k5UDCQtnFjdxB/yXB8OUKU5fAgAVtPEkEsFzjGHzEm05JqibeDr0m7cvsB3FXQh5KiV5f7wT3qehXXT5IWlzg4BZXu2CAj8vrqeXi3TrfjguYas8cQml7kQiW5qRt/+2mz/CegjYEWHu2KBAF5R33IiJ/teregTyH58=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(66946007)(76116006)(86362001)(33656002)(186003)(41300700001)(66446008)(66476007)(64756008)(66556008)(9686003)(8676002)(5660300002)(52536014)(4326008)(8936002)(71200400001)(478600001)(316002)(55016003)(6636002)(53546011)(110136005)(122000001)(7696005)(6506007)(26005)(921005)(38070700005)(38100700002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?btQLaSzPPGyPs5W1fFF/VmpuRHnyU1+4Ryn/VilY6V1KSpI03cPWc96igm8l?=
 =?us-ascii?Q?TghwtHVMCEwj9vE9FcSy4Syvza6R7XPMvB27tS2l0hiOZ63eZCZDnvA+wDTl?=
 =?us-ascii?Q?UvrFK5j9Z4Qhxw9f9uYfI6v/qufbR8wGnNHyfh3yM0/20YpmreeHlxc9L39E?=
 =?us-ascii?Q?cAjXw97oigprCrxgD8psLJPiuzx6MKNF6EpstC1n3RsU7RiU/FJCNUqSAisL?=
 =?us-ascii?Q?NyOv1g8/AWuGYT9nyJlHyp3JB/yrbZerM4L7MoshXEo4S5dqBqYCQt0/8zmY?=
 =?us-ascii?Q?2eV/NoZLwEtajSXFWlOKj+a5W1cIQoXZ7QCTXsHVBkt5JtLmn9EtJ3I/oMB8?=
 =?us-ascii?Q?e0a5/fOBA5eLkRUC9GEf5Lki68hUquHsEpSI9S0u6szLgUQMIPQPksuPW/jd?=
 =?us-ascii?Q?YsKekZswR6oPfcv9poT4Jz6w6R4hcf+gjNXt84gj0L5EBaiWxQIZWBFaR10v?=
 =?us-ascii?Q?KSsdd8EkRsG3czrw+z/1O57Cubk5eelQp+tE7t82WlbSULKuN04hPwc8H2qT?=
 =?us-ascii?Q?lc2L1BpsLdcxG7XpS+3HwUVBWApY7DqyHdC+19K6spnETC7wDCDC9OY0acw7?=
 =?us-ascii?Q?/9QD+uMYm9TOD7wJbNReV86UcgYBArmkIyUX6JZktiqG+TA6bMZEblxXVpp8?=
 =?us-ascii?Q?WreNddS4VE91Ka5d+jP8toxIVyJRjSVEybpWzqtZ0yQVnRGZPi+7UXmKmKes?=
 =?us-ascii?Q?/44Y6heumkn65fzZx91LJyXkmaYIX711ztg38z00CYC9L8tHnazffLrYBZTq?=
 =?us-ascii?Q?3PmlX++WtI/R1AkLfpBFrCguK5xbHP/bL1l7fLH695kWDe7fGMqnAGUWCqWU?=
 =?us-ascii?Q?dOeGGdYl4lPkZ5qCkRG/rh/R9q+AQnd9akK32AcH+WMxmOWWCd9jIaPf2jwy?=
 =?us-ascii?Q?6OiUutamXBLqSbc76+at6Zxmr6Y/z13ywqbhksP2him0Jqbqbe0S9pfZoSEy?=
 =?us-ascii?Q?09Di++BAgMJL7Gjg8aHBm5skjR5Q0HcG9mscUr6nwoS332DZQ40L8SrmfBKm?=
 =?us-ascii?Q?i5gSm3U1gMyh5kJHgBj/qMmncE82LPmH7uVUGJK4H7rUEG5ShY55LwBN2FAH?=
 =?us-ascii?Q?BAHyUzNm1wZ/1+QR/LvR2gxRD5tCvsDb4QTok6te1AeclH5kEYqvwQSP5b0a?=
 =?us-ascii?Q?krgjQ4dBBHQC/abUX4TP/mLOsi4PEGTuW20gaMUo4mrqh0F7LrwqebR+KTIu?=
 =?us-ascii?Q?FuPLzi6XwIQknh0Z/zRz13t+arzOjuO0LsfaQw4m1Is69kTJ9l/CpjDra6bX?=
 =?us-ascii?Q?9+t6SPO1lDGE1XtwRavy1GW8kt6gnVA+Z9+MPWv0fIigNAJjKqKyTCzlneQs?=
 =?us-ascii?Q?8lMk1SllEpp0gYuOWa0UIB4hphtQruqMaYtqHa8c3eHEHOJSxLw5ydr55fiQ?=
 =?us-ascii?Q?bxwbYJtDGtuBpgmEVJhTkrtRc5ANW9+TAFoSmZGYVsi0t9/XJvlZ8i86zgpJ?=
 =?us-ascii?Q?KFWAwwA8SdEUMrqfyb8FhUp0Rqw7RK0n8JB0FlEw8fgxWBbvLeV8WCo16ZwJ?=
 =?us-ascii?Q?H1XBtFDq4SVPU9I3DhHgMyB6kHf+1+a0QDb9mSGkhKx2KTXUyahwVahgV6zG?=
 =?us-ascii?Q?QvgF15oY4rFaIw0eS5+EdVyzENAE8LM2y5qg28sG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e938a30b-317d-460b-720c-08dac9313c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 06:50:52.5676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnJp4i3+PYzO16eia9ghDuMKEIbdVFpsbyTpCEJRduZo/NcVzIR40lyxAeU2ggkZPS6hswkZ2FLwHilZU6V9Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Xia=
o
Sent: Thursday, November 17, 2022 17:11
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Sider, Graham <Graham.=
Sider@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for firmwar=
e

If mes enabled, reserve VM invalidation engine 5 for firmware.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 4365ede42855..e970e3760cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -479,6 +479,12 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_devic=
e *adev)
 	unsigned i;
 	unsigned vmhub, inv_eng;
=20
+	if (adev->enable_mes) {
+		/* reserve engine 5 for firmware */
+		for (vmhub =3D 0; vmhub < AMDGPU_MAX_VMHUBS; vmhub++)
+			vm_inv_engs[vmhub] &=3D ~(1 << 5);
+	}
+
 	for (i =3D 0; i < adev->num_rings; ++i) {
 		ring =3D adev->rings[i];
 		vmhub =3D ring->funcs->vmhub;
--=20
2.37.3
