Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F210C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 07:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61D7113D45;
	Mon, 27 Jun 2022 07:08:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A69F1139C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 07:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLNKTS9P7/ec5Kzehpz47hIWNMgKf5jtWlQlLHJgUmTxkjdbdqSAmTaTzEYOB6X272Ji/BBwCsOQZ65rIkJU4/4SIKKwaMTEZSbBIqdpXOcpucCRc39x9obmy3Rks2ETv82/7RsFRLNiv42zYsCjBMUoiEJbmJ71ouWAR+30S8HPO9LlRijgDiQwtyFFyAIFMJnZC+DR/fTk3fDZ0/wTIluiyj76pLzUVZAuOJ2ggg16wvPONzLb3U9J4fm9S+7C4M5BfSlZ9fYABmOexhurawjc9T+IjCT9xGIN3+L6ya0oHNPzcvWeJy2WLFZud/72I3M70yhUxM6g8/daPhxfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvnU9MwmzZI1icTKwBxCXkCFeUsMxd8CGxTtk4/zMSY=;
 b=dLGm3ON/Amr1/YzUbCRmDcavhBZNlWGLriZciGnzidZkMjq8jntW9Jt82Zy5FO72A9G6c0C8JkWhFKXHHpqyHR5u6XRly8qWcxE7a4evdwqqP1Q3z9i3qPSveDjrRKhKIMywFWxpoAD5ZxvxdUDokEsEp3sYCUkMBDQf3VSc6Slq8GL5E1bKOev7s26jL+TluhbO+qKfNOua/WBKrZZgkjpVXUEikpHTjaVrq+LdGD4PLViCJEYq9pXAHJrnbaZhiLktIt9orhzaAXdLGid13b4B+asMytpgE70L2wUpsVZPkUhOHHV7ncwiA30GqJSWf14aOQ8SrFF82efauAu5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvnU9MwmzZI1icTKwBxCXkCFeUsMxd8CGxTtk4/zMSY=;
 b=t/SzkDEfPuK9liQgA4nBYMAEar1VSQDLHFTbMTjxwkHrHB3f6hNJKN1LVajP1JXy1CFpefkdfZVoasmUHHhedng6S+JUy/bLFC2RpEyIHetTMN2NDwm4HtZFwZpXd/6p/STFo98zuOYV5ddNjuYfZzV3TqDgEYkPyAUxfNv7bN8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 07:08:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 07:08:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove useless
 amdgpu_display_freesync_ioctl() declaration
Thread-Topic: [PATCH] drm/amdgpu: Remove useless
 amdgpu_display_freesync_ioctl() declaration
Thread-Index: AQHYieN0z8iR/MXlB0yg4OICJq7Vk61i1WTg
Date: Mon, 27 Jun 2022 07:08:00 +0000
Message-ID: <BN9PR12MB5257C44B9644F3C7C5F5BF06FCB99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220627050206.1415724-1-Yuliang.Shi@amd.com>
In-Reply-To: <20220627050206.1415724-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f6ac7e73-78ef-42ef-8267-1574f5cf3a79;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-27T07:07:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f8b4aaa-a841-4f0c-0d43-08da580bc544
x-ms-traffictypediagnostic: BYAPR12MB3384:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vn0DM6s2nKpmyPByU3GQUREGwEOUacNuYSpbi0geMbfhLp0IwtJmnkA9UvZpR33XQqHy8PVraq5QzSZbpok1PElxcGdrs82e3iMEJpL5Jg4GChYSNkrs6jnXwiDwzsGttZPyzFnhkRhfnNer4BUx1CEH4SKlxFu8T8ySCcNn/qVLZ5TwXQaKeam1TO8YoOXlwJ5kWf2IXW0z/K6xc7+H1RXTb5Oe1kM3j43xmG6qs/vYrNYfOgJs7SpvP61d1eb5lSnuGPbXNd/u5PRTTVW54+vU2UZcp2B4Cvv624VT1fIUAgie9NBN8VpJm8KuZekZZxz9gHQOr37ANmvzc67QrunRvcysR5IBo9hxghfwkz9+VCuMy7hJ7b4pp7OxmsGQHppP4rcrQGAQe1kXQZDTiECmWx7Q+mWpNeLVTnoPNCOU90FYu9pHGZl9cQaARPYtm9v3PAeWgbSb+i8/p9mJyiu3xQKV+tXz2QZs0Ll5CQ0gzzCjv7MkeamGi8QNICS0ManeLcsvYrXcD6TJnFPTg8r5EQrY+Jd5qMJONr2R4awFDDxJMFdWDN1ci8ZRZH16LqMpdhBTpp+6JVxXihBjgUZhfmcGD11GZ39k4G+CuPE9JnK0YMtnUpUOhgsDfOruceHheG0FjCaTffeMrE7Mj3zPlCnerSC1j2sOD9HkD2fcxDUDfWqGSbY/UFN9w+jB/gXHREoXOVMKsyGV5M2PccwNXoNHYDwaPFG9Pvx9Ru4J4jsayFp58eCx/7tDDcto+fvtM8dr3tEVbVYAxnq/ZMIdZG9DJ2P8y7IxDGsuCwQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(6506007)(86362001)(41300700001)(4326008)(33656002)(38070700005)(478600001)(7696005)(122000001)(66476007)(66946007)(83380400001)(66556008)(66446008)(64756008)(8676002)(76116006)(53546011)(26005)(9686003)(38100700002)(5660300002)(54906003)(110136005)(71200400001)(2906002)(8936002)(52536014)(55016003)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XMfXxIOY0xA7p9YiVHAVaqd54O2QEQcig2Jw6JrCCeG0Io8SfQVd0AYzMdFL?=
 =?us-ascii?Q?cNBzYz6ClwpNHmNjmIhiBsrCd/4rWqxw9Lm4CUOkiv2fpPesLjsy84cYcazw?=
 =?us-ascii?Q?7NQAg5TSuDD57VGhSd8AUb1Gg9xfUaJ4TOV4BR37HSNxd2nJ51D1/oH6nz0O?=
 =?us-ascii?Q?CNSuKLh0rIJ8kWERnr+9eS5VcTZdOqkYLmCDF+/ieKAySjvhlJ0MI82FaOK8?=
 =?us-ascii?Q?tfgGptpTExxdOO7g8ycHMNUpGPCv3WtZmBzTBNUckK7EZoC9BuGUtWmgkROc?=
 =?us-ascii?Q?n6hmcEaqDcbOOBkhxixdhMoVcr6htyWglZlYhroOkbik4Z/BIW2DEYVD/wun?=
 =?us-ascii?Q?HQWkRIWapSDnRGr/T77gr5oNsKB3LUB6D03eNRYzJ9CVfLdusjmiLBSQMIDS?=
 =?us-ascii?Q?qShVWZjFzog2eNTOObL2FYUjoKs8og6/Wq33v1EcyBRL0Uj3PH5WutZ+AKyr?=
 =?us-ascii?Q?3MbjLuN2C5tQwfc+9H8OcGumGhW0bAY0p/rKaEyPneTVgL/aVdg5PDMi88gg?=
 =?us-ascii?Q?zS8ymx5GxYeoWHvNtG7+S1NLXnoZNG6/Vd1eHop6fRTJU/k0GKDvzyI9Jw/m?=
 =?us-ascii?Q?+/XZT92/BCU9lVl7oJG+asK3FNuo9+ZMamSLwK0BokItq44MKqgmJZ7PHyQy?=
 =?us-ascii?Q?PjrH9O+DwzqQXfHZdRiH0+3k6GR/NqJPI52Ie0dzedT+A1qvBPX+SVjvxgT7?=
 =?us-ascii?Q?6nqczcwn5ERGmb7AYZ9CfDsNcWdrklVmH1CKxJjB2cME903/GA7F1z78B123?=
 =?us-ascii?Q?qCB8T1X+HRmp5lTyBFKBu4Iyq0Z5xaFyE7ezet7EnzvDiMTSUCgGPs/Xhsk/?=
 =?us-ascii?Q?LanHMT2vHFeMXMb+5DiokV2oS5v1qOG7AEwMKvOAg18GKhtz5lRHI+31EBY+?=
 =?us-ascii?Q?UVQxrvyhd2WefLpSRCMSp+FMLAfdZedv/sBkU3hxXED+g9KOMzfTixEJ4Oa+?=
 =?us-ascii?Q?VxgT/0ivTkKsRBd2aVw5O3o7yFMdPe3z5m+Av2nWCDGkQhN4MmxLA/+Z3Z2X?=
 =?us-ascii?Q?yLG20tgAsKwctihJ8gsCXUBOuAqtS/fRLTMXCRYNa0dxxFzOKk16944lUY81?=
 =?us-ascii?Q?Z8RyUJmUAolEsm9+4t7IHNxcSGJ3KkFCt5pKbA3pZUDOHwFgasqYCqKkHUzI?=
 =?us-ascii?Q?5ZU3Nqpy5LJLIc44yH2Mv/bG9K2+ENI5cKzm/yeOd3BGJGcF1GYM+YOHwDV7?=
 =?us-ascii?Q?Jz+Z7X/f5Rwet4bbNwoJ2FshMICSJLdoAkdkhDVm/6sB21/WmdRBM5YcYWui?=
 =?us-ascii?Q?9kDiZtw/9NFY67Ie/lr1uliYjlZYxoVTp+9+q1O/pLOu/qjl/ODazO0Wx6QA?=
 =?us-ascii?Q?wK77L6Ktpbd/kFpfErozRKRetqiJhSDmxWaqM7dLRXf1UcJXRw2wtVQLT9N5?=
 =?us-ascii?Q?5LKpaiErI8FN2JLcRk2tMQ6kpXCEIgrSZgwzGs31m8xXgoyibKng4K7jwjdU?=
 =?us-ascii?Q?pQe7uVY2OMoLZSKubygHE7VsvQnLE35gk8Z2FIHDKeksZBsdnSrPw0C8UTIJ?=
 =?us-ascii?Q?Qlr0rghfuxOrIZixis7i9858SY2Of2f7YAOd5o/ctC4onJvkDOvv/Pzd8JuX?=
 =?us-ascii?Q?KpHcqAaRTv3OMIkLBBZBqaMVqCeF1DjWmUvkrzEb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8b4aaa-a841-4f0c-0d43-08da580bc544
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 07:08:00.3646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnbmqStIGz0x34WTghVk6RaNiQi93vSusRDVVPn2BLbuYwyTdkF7pkCRkECHuwIcRN8b0yZG8S/NGNbHEwoxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
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
Cc: "Shi, Leslie" <Yuliang.Shi@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leslie S=
hi
Sent: Monday, June 27, 2022 13:02
To: amd-gfx@lists.freedesktop.org
Cc: Shi, Leslie <Yuliang.Shi@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; =
Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove useless amdgpu_display_freesync_ioctl()=
 declaration

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.h
index 7b6d83e2b13c..560352f7c317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -35,8 +35,6 @@
 #define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs-=
>add_encoder((adev), (e), (s), (c))  #define amdgpu_display_add_connector(a=
dev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((ade=
v), (ci), (sd), (ct), (ib), (coi), (h), (r))

-int amdgpu_display_freesync_ioctl(struct drm_device *dev, void *data,
-                                 struct drm_file *filp);
 void amdgpu_display_update_priority(struct amdgpu_device *adev);  uint32_t=
 amdgpu_display_supported_domains(struct amdgpu_device *adev,
                                          uint64_t bo_flags);
--
2.25.1

