Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1559C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 14:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC1510EBDC;
	Wed, 23 Feb 2022 14:27:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A9110EB77
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 14:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQh2GG5DTPTnsV7Vc3QG5DFwdhQz95/Uv90i+LJkhDVXiJ9mWBTX9RCO52SySOhzCvn54T1yu6t48NrfjzU/cYYxFICFGFY0+g51VaXXYI+6gCzmry1MbxbAIFu+8HECpBfLxS4ICEXzWuTLyqu/SBjr0Rru+wkoGSk6rEBb3JLYRQQLq6csP2l8gM2dIDsw6tK9BPRLASdDvMLCfIMkyxhw+ES8Keyo34hjij/QI/NnnTLpjxeVCUUAZmJhUzykAop4HG3MI+5A28rO2I5HQK5f1lSuPSzbhzy/ijCVGUOPRF0pNSOh8Z/FuS+5MFgdkHmNo+wlSekfj5zm3uzf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8qbV8zO8Hly1NX1/yiW8kPDLnBu09bRGrQ18MNgGc8=;
 b=NidhrlrhXIRTh8euRYjvVzEZnO9HP9DOHjIHxNjcY3dQ1gU19E+84FS5TFEoOd74Z25DTDdXq67NdJcWIHCBfYLGwHty4EITwBaKko2TLdEHSSn+zxolOdtMoV2VdXmV83NypFiiYRtzwRvdb2phOpcV/hXhNVBtARdtamucoyi84bNnLp4DuA4g0CE4WHGdwhlTJwyA/d7UFHbJxUePMn0D7/8oTHS3WVs+W/UwPUamZuP84LgCk3hn1Inc2I1AUq5Ni3lvvE3mhNvFsNwFR7y9k8Til3GyUwFXnbF/g5tet62e28lKPleSOOKZKgAQqAh3IDwMvFatruT5m4YS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8qbV8zO8Hly1NX1/yiW8kPDLnBu09bRGrQ18MNgGc8=;
 b=Y8/vQ/7BKi/JUZwfsXh9t4tTN2mUK41h61+ilflc6PBxg+N1awrtZYWu/2aRD6M6bkD7Vele3vcSsIAHKCmt7AkPXUBkglhqFO7RjHMhOOAc7jzrW9cKGlgS6FuPbxYewLE+08w51CtZVcNOxHuYrV0CWJE7F2rFlI/YKxYQ6ws=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 14:27:28 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 14:27:28 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/benchmark: fix error handling
Thread-Topic: [PATCH] drm/amdgpu/benchmark: fix error handling
Thread-Index: AQHYKMD2EE0XB5uHs0OXRexDV0GiEayhMWeg
Date: Wed, 23 Feb 2022 14:27:28 +0000
Message-ID: <DM5PR12MB2469F506B89147DDD39318A2F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220223142307.1659697-1-alexander.deucher@amd.com>
In-Reply-To: <20220223142307.1659697-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63453667-517b-4ce4-7f9f-08d9f6d89e85
x-ms-traffictypediagnostic: CY4PR1201MB0183:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB018398C49CAA41E391998441F13C9@CY4PR1201MB0183.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zfMa4DoPtSUCq0r4oV6ritA5c7aj/cI7DWtLMaJW3rM8xA79smELFiOLOk3sdj0bluFjtwW/vEFOPi1tLg0ZY0xn/nRMKSZjqpDJibljKUgGIn8MKimEqEqJfjN9LTcBhE9HaEz8XC3ydjpEjRUGWMnEUl2c4MOFf9xw6ndaSz3qz4atDhCjVhqcyuLLmozq+nLnIA3CQtMfk3laGy6fchwuE8uATmQP+JjnscVNRvo3DaW8wbfCTdKA8DVoF+Oj3yYdHKdWc8IUR7cT6XRI4zUtBQUwzq3/z+XCtAMWjgCjPylbFBkRVeal5XgxAD4ozKrlVdmhtONuQYutYCBWDEDaNR+Pssrl4QkTpXufvGAbatpMlVYeLx2ZlW/tYeZA1rf0ITcypk25jia4GvAuWDmpwd2XsVZCeLwpI2BcQ3a030Po2vlrsj/djxfP5kzGc/tCPNEuLQ7hMs6ciu33c5dss2ANAhv3MzS9zl3pw4VBpmbIwwcxNMiGkPDyDIp/OkLC4SyIx19GlFGJZDojWKOpFi2mxCkY8aoHWqjx+beqOz8+wq+Lj2DV4lv7z1Rxpf3MWxcFXmS5lQGrItOD6oiafkCG0zRAWIvJbpOjC0f6guRepCiOP4afpkVq6f23RQD89CTIEa0feZVsnehz7L7cMzwYKx8FcXGko8jweJaOsBZMsaaQSY1URPrl/y6yZBgPa/o4KPhcR0bdSAQcZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(71200400001)(66476007)(9686003)(66556008)(66946007)(54906003)(7696005)(26005)(76116006)(53546011)(6506007)(316002)(110136005)(508600001)(86362001)(64756008)(66446008)(122000001)(8676002)(83380400001)(4326008)(38100700002)(52536014)(55016003)(5660300002)(8936002)(33656002)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NnX+Y+etsFYvQMYkF8rfHSmXW+ZZatWRK0pEa7OfyDA4OkCQgZyGWR1/TK+v?=
 =?us-ascii?Q?/3R8w/w43B7T2OhIiMAjf+sbt2YQiTihFNw/IsaAAE7zcy48MPNP6GZ2Uefj?=
 =?us-ascii?Q?IgB/TVbD3o0/An0QZxqb2OlWjh8SDZyqeohRBs0zZROJZ2t68IMiAecIOjl+?=
 =?us-ascii?Q?p+EJjFFR/vNLuLwC9Edd0iBEfV0Z62slxhoeeK/5HunRZdh2OalkAP9yfobF?=
 =?us-ascii?Q?fTVwrgiBqxGhXtmV4CPzrYeYt9L9yAoaRrvzwxu38/GnKPEha5BzVBNZOahg?=
 =?us-ascii?Q?3W5AxGmrtQoFsEDJA8xygebfViPMjiXHuZdElmRVRndnb28dOcv+CfBRuRnW?=
 =?us-ascii?Q?rsVYIeUHaLSLXzHis5t6sTBE4afvNyBw2VRrKBO6DGomILtiuJBeaLapbf12?=
 =?us-ascii?Q?3gsCDUpQ6Z1v8nc0bObzftfAOPxQ0mNf4uswGW5UKub4jLy+cqJxD54KjnTL?=
 =?us-ascii?Q?urXpOUTtGDVR3caqin24llyEwDvIdxcVZONLRqvcMQ2untSsrMK6PVPA5qli?=
 =?us-ascii?Q?sooriBY1OC2jWZfzOpwWfB3WUQNh+/i4XPyIko1VlDlpqUiL3PwXXFA+OUql?=
 =?us-ascii?Q?tg/5G5/x7VWnl9Dsb89x9YoX7MhQ92ler+NpkGSqmPZBuHqZkCb5/qeSJPOS?=
 =?us-ascii?Q?/ZxXgVZNUAKRLX5N9T1mj430FxhRddlauPp4hmtR2J8Q8BxTRU5UcJLhbPZQ?=
 =?us-ascii?Q?NFq6ik+J1kM0pjjhSy1pTOVi+Ujcg5IZ/F3D2H/V2Qv6uI46hchctLjNsjr7?=
 =?us-ascii?Q?+YK9xdHZcqXLiV7i//uVfUJMow6w6yppi07dY4xlwY5BT+9y2aTH0TUxV1uw?=
 =?us-ascii?Q?YskqHtal9rEOV8IWMXYpBa0J0WLEuEQXqIiGWOKldlQRjsOOV8yEdvkIucy/?=
 =?us-ascii?Q?VZh7aVMfqXIJMMCPYC+1mYYA0F3++bFUaR+izW8hNt3KKx6fA07tUv/ozfHz?=
 =?us-ascii?Q?gLqD5fIKx4/fiXnaBb3rCXk5PuxVrNOkQrryyqNa9VlCSsyM0HE8lbDoUdyN?=
 =?us-ascii?Q?L7kZebWKzVesa27lrfR9kJIuwLO7wG4Cqj/BvkghyyHud8kyplssaGEdPnrl?=
 =?us-ascii?Q?To+ycs8CPEKSM9deW+jpWixmM6VMI8RbxJJmBVPWoeREtuZBEsl0FdQML4PE?=
 =?us-ascii?Q?d36WOov2HUclaeE2rk/wXQ2jPDmjj9W7KSP5Lx3vddLBKyusjJgZmvcnqwv3?=
 =?us-ascii?Q?4Yd8/UaPb3uX/71N+D09ganizAoThyVZnYR0WPmNLRic0mEAVVM7/8Qe0oPU?=
 =?us-ascii?Q?2VeXKlpNQP5y5BRvgcFXzaSffSTX5q6E4SFPxrXeqsw5kk2v6O8W1ffUlQoS?=
 =?us-ascii?Q?1uM157EPCgSzTHHZIVQAJe8Y4jcvsQbmE7e+YAlSffwELDCuOakZqrUQ+g5Y?=
 =?us-ascii?Q?VOWUDlmDXYVn2T9ySgN41lgLIlkwH2RPjPZ8p6Izk12IrWB6Jt1025SFGsJ9?=
 =?us-ascii?Q?DDImXXh6PAMi2UIKUkR6gvH91/4a95+DmcLYoKln63pEUFjMuKjZu8ZyNwqF?=
 =?us-ascii?Q?m2eUUP7/W7ppXy5/JOjVvUwBRmGGYXxY2sknWpc4phFhujxDpmSmGtCBByFI?=
 =?us-ascii?Q?Glmjaj6DFZxlvGA7H/zyEftM9AHLmUkNAJVbSI7wSgiXVCiGU4pr5ZylVdM9?=
 =?us-ascii?Q?1/rWR7Oz0K4tAozY2PQUh2s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63453667-517b-4ce4-7f9f-08d9f6d89e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 14:27:28.1772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbZwBOfmKbHI7UQUCpulDRFe4ML0Qh+COGJ4qDTCl4qVzLRuMIlO/omJ/AQleMAt3gxTXiROU9diycW1IuTTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, February 23, 2022 10:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@=
intel.com>
Subject: [PATCH] drm/amdgpu/benchmark: fix error handling

Forgot to assign the return value here.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_benchmark.c
index 3136a9ad2d54..edc6377ec5ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -163,8 +163,8 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int te=
st_number)
 			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
 			 test_number);
 		/* simple test, VRAM to VRAM */
-		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
-				      AMDGPU_GEM_DOMAIN_VRAM);
+		r =3D amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
+					  AMDGPU_GEM_DOMAIN_VRAM);
 		if (r)
 			goto done;
 		break;
--=20
2.35.1

