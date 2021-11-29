Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E349C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 06:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BD26E831;
	Mon, 29 Nov 2021 06:36:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA686E831
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 06:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c86ChyOab49vM4yAzihwgVb6zyOYeeviJbcHH6XYlc/eYLZZLIB0lGp6V44LqnRzwExK8D2mqHVEKqWqzEoeMhSp2qygIRB0+TD2jcTc3/chVGlN7Z1A9uChGHE9XoOufBy2XrnHTSz/R3sVWxXx5fM60iRwYaISiy+qwTn8FkSmJPKexBd/gwow/VM6DTPGme3aMSToABP4rkXb0BGIkJpRkBd7cZ300J9LjK0CRtGi1ItDo4wdk4ARyl/6xAiojZ7V/n4GRj8sEWGh+TM3sv8pWOVzlSb1VV/rWCoEbS+7NPxe8LIKBn7CmCYYnLRzkTjLYNFVXgu0bidfnFuX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Myopsr73Yj4TJjWbXwhpAIYnWkdmz8DDTdUeD3mNiMw=;
 b=dn7kmXSp9PE+K3yqtO+ZJhc+ZtFtBLGL4yc6iY1kQ0pBhO/nHmm5rqTuNGPr06E5KPp+yayHC0/s5FkH7teh53Rw/JnZu1D/kGHZBBtRQ+bS7kEptfPxQ79PwFh994VEEp4+I4TbWKMdSpUUu9Js4dl518jTHThDmK+y/rPU1+Bhzs2dPjkPliHam1PrAkdAJAPzPxgrm/blczwAnckri2coz5sysVh/yHkKnlG/FsxwrskQcGxLSwZPf1LXVZ84dh+baXA4Xie90CeRW2x0oeeYt3k8TJkRcu/Vwwig796SGTU2fNzBrND3mmd90DOXJYkILh00hcexHQhZd/uZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myopsr73Yj4TJjWbXwhpAIYnWkdmz8DDTdUeD3mNiMw=;
 b=aAtV1O8zd6a1lB9ciTWwb/KAQGpakqxF9SrJboZV5MDPy0A3hjuUMg83TsJQqMa+zm09cgHl15iiL8bo8xDF4fMF06xvtQx+ryLyFZY3t/18RoRmBJFd7sWgNY+xBxsGAAbM95ZzVD8l9WkjOJkoU0Reqmq76OuftCY24zOjTwE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 06:36:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Mon, 29 Nov 2021
 06:36:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: adjust ip block add sequence on
 aldebaran
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: adjust ip block add sequence on
 aldebaran
Thread-Index: AQHX5OoRABmQ9ml+YU6Ld1vcSQWc1awaDFBQ
Date: Mon, 29 Nov 2021 06:36:18 +0000
Message-ID: <BN9PR12MB52578B3E6419AA1360CE3F60FC669@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211129062634.8559-1-Stanley.Yang@amd.com>
In-Reply-To: <20211129062634.8559-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-29T06:36:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fb4928bb-7ccb-4eff-b460-d0eab3e3eb76;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf82415b-6b37-4c62-e56b-08d9b3028d33
x-ms-traffictypediagnostic: BN9PR12MB5383:
x-microsoft-antispam-prvs: <BN9PR12MB538379E73F5FBF4B681376AEFC669@BN9PR12MB5383.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xgp5l1M6x+8VPJYbsFyly/4NNOJ8Tun12rIOfKwtrOTCsLK+jsROZPENvHsaJQs13nNkineZ1FWatQDYj2DCZxPWZsrHuK35sqelZO90UoCQzJQvTF2jFpq2ZWe6XxkofxGpXivyjrXmNhbLjrc3zpIT0MEzkGcUyVcuqzVbEsKeVJ8L87iqHeoPO4Nefj0fs5s1gj5lWcwmUF0QwD1XBy4OjHn17FB2jvoVDCLTxWDKWqLW23dmY+/ypYXDtgsWqYIyD5lQ2Sbsg6u+SUAhKvA6Q3vi2/yRcIQDafWAA1V7lD1f8i9kHXFh7qdbB2jhVq9Au6+RG7xOuhZJDSnkNNlURH13/Wk7DUKhXYLk6HBRDOq2Yp5r3IwWHpk1fRVjOiFSowKfJyhcGkCe2KFn762lLdy751eQ4K7qz5QdxyJYAxzdqUNLl3oSmGS2W6O3opSBnZqgnQhB+fjv3WNgYZkVDeW+UJk48lD5DY9KUUWy3t8rxAvW1ZAp2YPjgwEIW4JdgjxxLxbSSPfIM+s8QqBHJHgWeYQMtRhJclMmp8mRV2OVzfZyxk11q6/kMpKqwVT0xIERywuwjL4zXipPeu/V6vMpxNSWUFXSUBJuQjBcEROk24joIfdw1I8Rgnh/hsok9eOQezSxerjmcA6MLFnKnlC7BkpXVeMrWdVLp9GrfKkKGHY87+OSfDOlTt2quMCcyHzRROPjzqGmudFc6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(7696005)(33656002)(38070700005)(508600001)(64756008)(5660300002)(66556008)(66476007)(66946007)(6506007)(83380400001)(86362001)(110136005)(122000001)(316002)(55016003)(4326008)(26005)(9686003)(186003)(2906002)(8936002)(53546011)(66446008)(52536014)(6636002)(76116006)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sg8AHY91yEa1sH7cF9hBYYL2MOr56xxZQPCyiYFkzynmdNIMBSkxt61X8ACA?=
 =?us-ascii?Q?3OOXCd7EYcuhst6y7uYMrAPXPPbZUFW58dF1Z9t+wj7lUejmukltTTz2ptQk?=
 =?us-ascii?Q?Vj621oOd17Sm58iCaNx6CpgGhbKdSXmZlm49dc0sEoXjpzGGuS52Rec8yAJz?=
 =?us-ascii?Q?FLkhc+n3DFWGRAv6oplPlF7qsnAO/3TqowXuHnXXBibKIxCazk3k9TNM3ohI?=
 =?us-ascii?Q?1hV3u86jH6Iw6ZRolrp+01wpHHDutQShpD4HAzHP/DYAkoY144gXssfbqVM/?=
 =?us-ascii?Q?kmzvrwFfd2RCNAAYUYDdrJgYUpzJLjfCQJlAsRsBSC57PdA6XZc1MJ2DTY4x?=
 =?us-ascii?Q?G7lG3PFrtgzm/JDep2Qw8aCHc3c+W0ApUblrM3vfKYUwf16xSIVO5ju3vJQj?=
 =?us-ascii?Q?UNZV+TzY+kmGPaefZHN3U/Ngwoak3SPWyG1gYsPp+nwYWh6vo+obN2PSBir0?=
 =?us-ascii?Q?xJWQDjE183TvfY+p0H8GUPwu8SbiiEH7Rjk2v8gP56Ooj8B9Wanw0N9aUWnA?=
 =?us-ascii?Q?IUzrK8itZlluXEe9aVjrG5bedZvCuqOfzIwFBwGAWrKBA1VCj2qmzuTiJeeV?=
 =?us-ascii?Q?FmLGjGLNNXpZrDJ4qSekUBqD0AZ+8E38wDqW6zwDiDfM7jZUYarUXCVdUC8e?=
 =?us-ascii?Q?r6dAZGaNShVqm7pphJWQBb+WaE0GP0X0AcUUStT9ihDmfcZuH6ypokpUZYL4?=
 =?us-ascii?Q?OOYbjnjS+7Np9CvXXpNBg4jVuKXfqX2Bk0qXC9EeJ7XnhfRtPHTN4bPX4obc?=
 =?us-ascii?Q?JN+34luLzsJv+eF+Ca6xR1fkVDXuJFs8hqIpC2oZgKcRPfXtSeQaVD/dQtnL?=
 =?us-ascii?Q?PYJw0apmOJGKWd3b+SRQG88jaBEO4GHao6kXIGIFssI7vy+U1EIFqvtTwnUI?=
 =?us-ascii?Q?ZodEf67A6Uj78frmNoD8RACT9fLXsyuxVlgP5TVCVTQylT3dRBFhQjKgLQ8y?=
 =?us-ascii?Q?Bn0RidHIMrkWfHkF75T9Hy0VQnnwaq8ONmobWBGmdxrHP6YqttzWcSZtLT7a?=
 =?us-ascii?Q?npHTr+Hw07M4TiYNrbWKGaTqCrUZFUMnF3hd98Cv4ztJY3YTZWtelmkUD0vX?=
 =?us-ascii?Q?mnIrhH39y9e9DYvpQ1LsYK8sBkmCbfhB/dF+3ka4LNPzIeatP5aj9R3I5k58?=
 =?us-ascii?Q?mOryEU1CU+hmhoBpNs2WDIGk0hSQB8LrHnvbPUntMLKzBQXHCDnmaLnp5q/O?=
 =?us-ascii?Q?zCVX77DJaVEdXBvT3GyVfUawjISp2JWp7f7pgpwsCOzUHTF/aoSdXUEHpdjj?=
 =?us-ascii?Q?DP6EUaMJNXzSDBsSqgpERBFhYKsgQ/3D3DNjrXd0luFn5T4fZhCVHNGOnJbV?=
 =?us-ascii?Q?bdougJJOvnFhU2kO/e1J19vLV0MFR7PolcO8dJoMLcdeDpKsj4UVJ5IaLTyU?=
 =?us-ascii?Q?9BGe8Ke7IHGKngkss3kFZas4RZ7/DjV9+LT3/AWsOybr93wpHWvaZ9GYDo74?=
 =?us-ascii?Q?/XCm+dxRuorpjgi04cu6/wigin0F7aQKDGWlhiTWoCj7EHjIwVmbte8PS/FI?=
 =?us-ascii?Q?UW8HdpQ1L5ehT5fzzvX1xG0/6fOij6mDkDHPWzgYbLEtUOKLoiMECAI3OjFh?=
 =?us-ascii?Q?DITaRx1HoiysVQ3+rvFthRnYGfy8BfH4i43kXbL8+3aTzqIfHt+N57E4bqfr?=
 =?us-ascii?Q?T68bj3VcDnW/uazAqREdxt0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf82415b-6b37-4c62-e56b-08d9b3028d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 06:36:18.8327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImO61ojcIOh3Ja8la5aYBa6wjPPei+0G1I2ukQG+hibqHVK01EtWyEkqY8sQpg2h7omkI8uj4VlBrFrzJgD1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please fix a typo in code comments smda->sdma. And double check the code al=
ignment before commit.

V2 is=20

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Monday, November 29, 2021 14:27
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: adjust ip block add sequence on ald=
ebaran

Reason:
{
    [  578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset begin!
    [  583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to disable smu featu=
res.
    [  583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to disable dpm feature=
s!
    [  583.245639] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* s=
uspend of IP block <smu> failed -62
    [  583.248504] [drm] free PSP TMR buffer } Adjust ip block suspend sequ=
ence on aldebaran, it can fix disable smu feature failure.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..dc1d88a31f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1309,7 +1309,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
 		}
 	}
=20
-	if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)) {
+	/* move add smu block after add smda block for aldebaran */
+	if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) &&
+			(adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0 ,2))) {
 		r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
@@ -1327,8 +1329,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
 	if (r)
 		return r;
=20
-	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT &&
-	    !amdgpu_sriov_vf(adev)) {
+	if ((adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT &&
+	    !amdgpu_sriov_vf(adev)) ||
+		((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0 ,2)) &&
+		 likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))) {
 		r =3D amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
--
2.17.1
