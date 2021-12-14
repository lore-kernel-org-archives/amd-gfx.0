Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B5EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 16:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46E710E57C;
	Tue, 14 Dec 2021 16:09:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF54410E57C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 16:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHfB64B37P0s2fzT0HW4ITRgft52IoApx2RcrFUZgSsynma6Em6tJHEwLeF1LmHAQx85tptgd+wJiAg+cYW818KrCXXJ1ZxuJoDM4acywKdOKZ5xhz3ff7qr80tJFQtmMr4Gd2CWJL7KlN7/LSM/R33rk+Ta1MjIUqEE88Od2gat6AxAvmm2b75spWlugY8zz8gK2gJxKFN4PkF1xZqkJr4REXoCBTShM4RgWuUW20S+pzk8cD63W2Nd9F2pfVKLQ991rwV4hkZcTqhIW3JNmAMAvmOytpnF+22jM0kz1g5t+2qzGSnNHNlWLon1yhMjUsEGKck3piavffH680pFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki2INlWPNuy9Ln9ludvgFm7Mtuwr0TDh0w/Yr4hQ+UU=;
 b=oYhEDvdlwEBahvjJsBp3YRFd61H/W14kpgUfRFq7IxC4FeAa99QkB5a9Tl30Sewh+omjSHdcmzKtwo0CrMtPzOztf0Z+dcvNgv9eN2Vx9hDklI4cvx6cstskMyx2TtOaSngu7Ya/aCrvQG/ZFyZCgHMgvyH5LFLpfJRfSXEgz0Kgxta4ohmMgYq6wXKfNz2gVIX5aTf8q8gYDnTpQLXiG34ybDPAKmwiLt+ARWjB5OcQytxIEbkFtitqWpgql+oRa/q3de7n9i1P6lhH80+vLZGx8G2ThqoqMu2KW8mLy+9M1ef2lLw+PKzK3phuoeUDmGyOPM5t2AO5ntGZmSdkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki2INlWPNuy9Ln9ludvgFm7Mtuwr0TDh0w/Yr4hQ+UU=;
 b=kI6c5IPNRDECmdhOMM8HnJHlCnUNSWDLms2tqlM57xQXIQXZ9Frwu4rsc0FqrRBwJcTQVZQ0XYTG1xQB9ZNVaz/4JjDVaKo/5pxuQq4SCQGMqKhQEcEfIG9ax6zEyPwXi7RUUSzIIZhtAzpFF7TicottkwbXYbRJF8FDUxqEFm4=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 16:09:28 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 16:09:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in
 SRIOV
Thread-Topic: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in
 SRIOV
Thread-Index: AQHX8KGnDj2XLCny5UmzE/fZDcC6zqwyJoFg
Date: Tue, 14 Dec 2021 16:09:27 +0000
Message-ID: <CH0PR12MB53722828870E190D92ACED82F4759@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T16:09:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3e700539-e699-4a88-821b-3dd7de3ee6b2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-14T16:09:24Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b40980b3-9176-453b-9e9d-5f97a671ee8b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fffaa526-74fa-4715-3728-08d9bf1c1b18
x-ms-traffictypediagnostic: CH0PR12MB5153:EE_
x-microsoft-antispam-prvs: <CH0PR12MB515340BAB62DC8AB3FEF182CF4759@CH0PR12MB5153.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DrRegKRsF0kHpUHbcmDRgxtbO+axD0lZXmqtikm5LfziTPSFayFLBjZz/yXfT0CAxUzchuJX4shmsMOGjA1IbFVZ7HmdhjhjVGxht/8BcZx6A9DkwHDmvNSyfrOMKstKAA+p1yLjsN2d7VB2DUXsH6wJYlxj9Zs2nlI+WNGHJjQl7kM98pGdRg9bRffClxBaqOvTOXL/m9K+oRm+Y3R3r5/HvjMTgFM/gcQllMXvEH4bMyuy/Br1s9aE95fFvafaJqY/WQ3lKGy5tYi6yRjA9A893KmZ/rvAi47Tq8ULhtRARnzhuMUMIQvF/Xv9MsdgsAbk8RZMwOWl0VYCOkP7toKKykWbqpTQmCvJ0VgPf2tXl+25rsofVAyCUZm8bvGcw0BB3wMK4z6MV6KH9Hyt3i8013hw1ez3o2LPHt7vEUEvjVaMxSHzNc6jcOaW6UvkimYgs2QhfAdSkNnRPYzjazdryKG8l69KyakEXCu9dHUjwpE5hcHHCQ+IHwiotJekzxtFaC31JpHaR4QaNGoGMeasRNx+eJY7J3lj9hRzd4fuazBBD2fqp4aiZ+34VT8xFx5nmCUZP+/dak0G+xbDXByqzjtxkwBn9oMF8oxc+9JMukq6rQb5R0BIQMmKXfbyeb3aG2B/FTwUSlCNxEe42YktOBi7GB7PtitHBYDGjrrOsKH02u1Ob/CuYQ5A/dTeKAUpiBiVvkQI6dw+gkNM6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(83380400001)(316002)(4326008)(2906002)(38100700002)(55016003)(7696005)(5660300002)(110136005)(38070700005)(33656002)(8936002)(122000001)(54906003)(8676002)(26005)(186003)(66946007)(53546011)(66556008)(9686003)(52536014)(66446008)(76116006)(66476007)(71200400001)(86362001)(6506007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iYtCvEMeb4OFhkU6tsUQuj45hxl90aWbTNJhFJnSj4i5HcWP/zPzgVOb4hG7?=
 =?us-ascii?Q?OL+QexQUeSwRQSQYnIZaCZiyMCv1SUawanl4yQaxDlyJui7ha82rD5geprAi?=
 =?us-ascii?Q?FcEBp/ry+5wonn0ZfIdfKnrOVSiTEaVBZUMY585f+OjYMpTqF1KdM02MVIIu?=
 =?us-ascii?Q?kPHDSWu8yRfsWM2624+tfDoViASpg5S7jhhmFhupSvk6rmuMBh8Q+g7fz59l?=
 =?us-ascii?Q?tjR+4N0Gv+Yi0cKUTml3cEYygUDR7HLKYVNYnZlTm/25qiLX/IY5wAklwhv4?=
 =?us-ascii?Q?kDAdopsbkJeuLVCfa22l8U9tObaJ0AuXTqyP8Wh26RIqLKDHv392ub/setKR?=
 =?us-ascii?Q?SApkhQDshgwxj+pm2qD9ddJZU/e+CVFiiUGQ79Nid2lsWrBcOqEoVIqXB9eV?=
 =?us-ascii?Q?alFbP7dptDGL2xqnzVu0VyVmwOXAKIsxHBXByRq64d4YYvlNNjgb0Saxm0tW?=
 =?us-ascii?Q?ciDd7+nV43hT6BEuLnFl3lT2Y+5dfOK/ZBXfCNfpRRFduxMhFAwS6n634hFl?=
 =?us-ascii?Q?uib2FUyMrdP/u7+pjjU0Ayp0Z1E5j9ujH8oYOJt+VWPixO1Cs1c59AnQBX9B?=
 =?us-ascii?Q?mRkr5BlvmudByhLUd8WUdsafvKa47xy3aPksC4GHk2gVLxLr0GEg7BKTv7zh?=
 =?us-ascii?Q?dZtIITa+svmtQBvQcLule2am18jdrcvx1BV/JLSmGOr46WxGS6sUcNpMKw2m?=
 =?us-ascii?Q?HtJEjoJFNk0Wobpp7kBLixrFhqv8mMT3xHj+dETUyT1tOubUme4TkaMo2htn?=
 =?us-ascii?Q?QjpZJGv02cBVTPUyY8viHzf8WK24XdbU9AfnIFIbgL6/LDFeVdVT80ezA1Af?=
 =?us-ascii?Q?76PZloiPg4bwEG8oOHt/UVSyCngelkNptay1i7CXKQVbehwRNiyEKVxBbFFM?=
 =?us-ascii?Q?0PXVih50RjYOaVpw3EDF6KRU89tFXjCtHd7MJ3q3lEM6vZX1xxg9arTM/Ne6?=
 =?us-ascii?Q?2oxc/IAOuoou6GTskxWqS5Ju9tXbmpG2B1QlmdaYT22cqUyU6gTwhekLmi+d?=
 =?us-ascii?Q?xe4BC1TqK1qqjoEzPF/ZAaXFCw+lUa1YBZe8nI6gbXeflRFBYIy/W6v/oLIk?=
 =?us-ascii?Q?8k5UEClCf9mXByI75/znOQ9rabdtEsfaAHoZ5ORPIgHllmwpEPXzWepaOHg7?=
 =?us-ascii?Q?znj0Lir0kvR/OrKfkDdVHjyp0UlfxnoAG7VbD+ZIAAugDQGrTnrCtw8OVmq4?=
 =?us-ascii?Q?Y3PfVY8NGduOYPOaNtznrcy2FmqQ5VuLxj8zaLCZv3A2/0bSg7J7jb3K2TUK?=
 =?us-ascii?Q?ie6dgJpai/YJHT6ZotRs3Je7inRGBczfw2l6Ns/Iv+ngwG6dvAPQn5PoClTl?=
 =?us-ascii?Q?jP9VGiweTmLKHEYxSBO7LCP3Q+fDfJpB/qTQU72BbIR440GuI00xMIQ+Q20/?=
 =?us-ascii?Q?SxoV4lQnzDbgxExGlzsoVQ9fDymSOPq28uOGdYx4JGX7Vq/urRg8357PP4d+?=
 =?us-ascii?Q?ZkOE/tbZk5yu+7QyFO4Qkiauos9qa4+hsSWZqzpHD5ri67jnyFboYSttmUsl?=
 =?us-ascii?Q?KHyH83iQAXgOSlNpiboFecP8SSgRGTdZP/94rWEfetYl9X3In1pJR+v5Ju4y?=
 =?us-ascii?Q?+BKmr59Gk9mHU3hbGsj92zErWIH3yExwSgreya2/QqWslttxrVyeTzhsG/zq?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffaa526-74fa-4715-3728-08d9bf1c1b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 16:09:28.2185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW8AvVvu9nkA2u+2V6n/xJ6uJLOoZkkjJqDiSMvDM24sGAYUyCCFqpXGpxyJq/PUZm/Cx7Uop+Ohj/iSTyBFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

These workaround code looks confusing.  For PSP TMR , I think guest side sh=
ould avoid to load it totally  since it's loaded in host side.  For gart ta=
ble , in current  code path probably it's ok, but I think if we have  a cor=
rect sequence in SRIOV , we shouldn't have  these kinds  of workaround.  Ex=
 .  Can  we try call  ip_suspend  for sriov in amdgpu_device_pre_asic_reset=
 , so we  will have  the  same logic as baremetal.=20

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen =
Chen
Sent: Monday, December 13, 2021 11:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Horace <Horace.Chen@amd.com>; Chen, JingWen <JingWen.Chen2@amd.co=
m>; Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH v2 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in SR=
IOV

[Why]
psp tmr bo will be pinned during loading amdgpu and reset in SRIOV while on=
ly unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

v2: fix wrong judgement

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 103bcadbc8b8..4de46fcb486c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2017,12 +2017,16 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
=20
+	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))=20
+		goto skip_pin_bo;
+
 	ret =3D psp_tmr_init(psp);
 	if (ret) {
 		DRM_ERROR("PSP tmr init failed!\n");
 		return ret;
 	}
=20
+skip_pin_bo:
 	/*
 	 * For ASICs with DF Cstate management centralized
 	 * to PMFW, TMR setup should be performed after PMFW
--
2.30.2
