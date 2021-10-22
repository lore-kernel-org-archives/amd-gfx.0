Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F77C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 00:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2063161052
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 00:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2063161052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E5E6E507;
	Fri, 22 Oct 2021 00:21:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075546E507
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 00:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXVG/l0Gp4yhncZ8t+mTUT9NKyB4MIan0/KFwmaOHX6bHjEKWNfbgpPe6Jftg2S9K/XFYS6fe8vMOOSi1PMj1Dt3pgRDfh0uKaopjmQPMc++fmSnMfgnmm/RgL0rBsxHAWPJaap/63Byu9QbI8Djb3KEtYnCSKZ4FxI3wX+eDp9xE0dWzKU8wNGNESQTtlYWH4aE5Wf9DMlhDVbl5O+ToptsFFismUha1iqwTxbUIDGvUmjdhsk23zZCAcvTUsYwcyh2NbOr7a6EK8fC8A2H05+hfan5xiBvXcOGnU1p4ElMexY2nWaidmRH2cdlPIjlfw1DXkyDZ3tosULbR55wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWy5ROGytBTfUIzUhyNOobg5xxyAZ+I9Rhg3bQVLWNM=;
 b=KxwD0aUfiu6p8AIJ5/iXmvBzCqSfmW9UBPw+5JCMjl6xtnQ7LQIR+5pji8P5a0QiaTdiyLyeLfxYtURj9F0uFXeDzoiD8NfVPoVyZnKwmi5vVy1szH7rSzfnYyF6Z6ks1Am7WEbbUx5XlwfUYeiv0K6W4dvIY59S6IoIzFDZ9/h5ue0kPhic0F/4DOzK2OhRBXnHAPiyodhAxH22Z9LqURtl26nTM7aYJSSfIvRIPgVtXhi+E6rU8mjcz3AgNX3hqfu6aXTo/tcqRVjGMgVxFC5mc1TCKe1BWlzkCh/vXXR9ItK1ldiWCYlLJuLPoLHgoAvCOvzNvmdySN0a1RoTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWy5ROGytBTfUIzUhyNOobg5xxyAZ+I9Rhg3bQVLWNM=;
 b=aF4FrgkjMgr4eqPtw5mfjsV9niFfbJBuQ9PyFuDYRUzi3g+iBUJmGWC1fUNrI1quGjJV06bvSrEpKj5NxJ28J/3ppozZIuDfTFURXFxxIfXsaPFF+Et7ruavEP8CD9E2c6N8qy47aXulwzD7fg/NnIWCudZ1sXjUdImHmXqP7J8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 00:20:58 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 00:20:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Thread-Topic: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Thread-Index: AQHXxsXfnEzLpIdewE+1tZhfcDi3f6veJ72g
Date: Fri, 22 Oct 2021 00:20:58 +0000
Message-ID: <DM5PR12MB24692ADBF61EA1E62739DF3DF1809@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021215134.224476-1-alexander.deucher@amd.com>
In-Reply-To: <20211021215134.224476-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-22T00:20:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f0dd7db6-f97b-4cc7-8d37-79a542845258;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4d4a7f2-5156-45bb-a14a-08d994f1d25c
x-ms-traffictypediagnostic: DM5PR12MB2501:
x-microsoft-antispam-prvs: <DM5PR12MB25011954D3B2ED94D68868C5F1809@DM5PR12MB2501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bizYm6eJV/IJ39Mq3sVqyUtEu8C2RwK/L+kd3DMqQp0cEy/1aWYLI+EL8UnwzsCW+9HOerJtk1oGD+SRXXecJOCMgW2v7qXW6VgPnunXVvnKAeZpv3CXoNzJwPrp9/C8eWPLCQ/xFZiir3Gj5z7O3seYSuXf7J4Ez/HPRDULsV3JRLgEs/CO5aDnl7mhpub9z6iGxIjNF8k7LJI9lmNSP56yQq0tV3Coi+x8zqKyRAjc8VzPCmduIlRDFIlFg5CJxplCAxT0R5pfYdACIknyNshMSGlIs4wHGjJETOutNHjxE47ehKXj4TFCmH4NrdpAdXhanmDTl8EdmLoENhLNdF383FkpydIZhU5dxhWH9isN+dSAl5Zjt/KYoiguYhkroYHZE6Vt5xFIsd06mEmxmqjiUxZzYm10PKkNzhFBPFPuOJHJEO783fB0FXjWhjY8JTnk0IcL0hIUNZga6tJjAXTpFoR0F8JjCnVCMXbUh1vty71BZz2AKpfWZMYgLw4EKkfK+atYgx53DX90pDcqElOoDmXgyDmbG75mRw9+gkstdu/LeutKeR/cddhMFZUtSrdU63LDIiEahsWipOJtboVl7tSfqEQpE4MfyP8BqvlHG1eEky/VA5ZfBj1dOUu+nX8XHu48+VTTyDlFH/Llvc1W/EG2XOm3P2yUW2mz8Ks+ry5LJ+P3RdDlE1f9+6mTs/XT/frhnZcZgb5OF/Gmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(966005)(45080400002)(508600001)(76116006)(66476007)(66556008)(66446008)(26005)(52536014)(4326008)(71200400001)(33656002)(64756008)(66946007)(2906002)(5660300002)(316002)(38070700005)(8676002)(55016002)(110136005)(38100700002)(9686003)(122000001)(53546011)(7696005)(8936002)(83380400001)(86362001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iH1Lnjug9GkLYcmHiT57yjGiN8SeLdOWFdi5xCuALRnP/Ab4DfDdJnSsbGTx?=
 =?us-ascii?Q?VVjjybCJ4eTDx53MUfo0//KNXr9oY523mwPEIv14GsbDdAufKYO8MPG5kiKi?=
 =?us-ascii?Q?vtPz06X6mJRUYiyPhdjuD46O49zymIqQ3Ca+Vx4WGEWgFRHJbbvlIytdLXir?=
 =?us-ascii?Q?+QJPC94tnNewv/LLmvgP3mujV+OEimndOi3XNqjqZQwvBcp2yjaVI3yWHV3R?=
 =?us-ascii?Q?0Fif2cnUZaql/EGITMQ0eD7ZrESgInwkgYsFJQNIUMvmZmBMcKt/hf4Ij218?=
 =?us-ascii?Q?jqQ7qI8beN41IyaBdmRCCvjRcq2eecjS0Qnlnf2vV8o30iFWFf4Dn4R2f3Re?=
 =?us-ascii?Q?Hd7yIVWmzJZw+v+msVdGmEeleh0dBHHkljtsdtiH/f2iD2NuXKO2rLhOfYmD?=
 =?us-ascii?Q?DngNbakJ9ij9ENhXGLMquSFTaXjTzIQkGkHsZjuUjmXw6HX6s1Dj4+RaQdjG?=
 =?us-ascii?Q?f6WROAFkyU+dn2FbRpDPJh3fQVXxu/pa0CFiA0yWb+dyQ+wfbBk5Ym1ycpKX?=
 =?us-ascii?Q?V+9t00Lu7hWobGaK8QhPdQcF49fIT+zUcoGwenpGi2UMiy0Fkg7UDLYiCkuw?=
 =?us-ascii?Q?2mLLER/PacapinhT1uijVtypgD0yq53wjU3DOJNlbi8W1jbTvb+JwYqnW9JU?=
 =?us-ascii?Q?sEGOvKz9cNb4SibXFcimKlNEe/rSHeHNu60ZGX9k5bu4MiVFWzpBJYQ269i9?=
 =?us-ascii?Q?o3QMUlcFWdj4hMb4XBOLNQnjgkazuO4MBWEMXpucmkCKXDgh0xkMdUA15xyl?=
 =?us-ascii?Q?NnyDvHqz6FfH5p/6A8vW1NwxoeYR2jRjFa0wAAC7IZMLmNNVFacb2YiIDmML?=
 =?us-ascii?Q?KczCE51HtU/6ON270s7qyp2pwbPnj04QgHgqfRy7TrMjLK5tH3koKxj0HdeE?=
 =?us-ascii?Q?AhSi/n6/NK2vuQTu43bcDJ2/65wprFqsKwxeXdvDfG8wpnfSoMB+ffICbbZl?=
 =?us-ascii?Q?2SZOgp7lNiPsODedDEc1KYY5vb3PWv9M11ubU6fge4EIL1QU3f2Q5PVvYE7F?=
 =?us-ascii?Q?+rvcNy/r3SGW3ZgjQDVUAlbBwtjVduWDy0YjLiBwTisjieppLpIVD+vLndEl?=
 =?us-ascii?Q?bMG3tl45jhVELzPhDIVD3DzT+zyPfl2CYL7QHGnMbwm/9KVg7jCQB7KxFNRh?=
 =?us-ascii?Q?i9KIX+06GU1obo8SI9NVj5YEUrmZwq1nUnKGbnyNbYfS2AODJUaucYgqPEVL?=
 =?us-ascii?Q?dVzMo9f8lYniOymlJBw9ObwwnPQE8guK8bqN3Aa3pRq9deIRn4w6hdUeFn4z?=
 =?us-ascii?Q?7oUHwMTwQBEDpvwJeh84D8DhV2H3FhVtcpzsUpLFjlLZVCKeNoj+yQmQx3mW?=
 =?us-ascii?Q?YavdlIX3n576s4F7/vFFP0n/K/eZ/GKhCYmouTz5cVKt6E0zcLT2szN/gVbo?=
 =?us-ascii?Q?RyMee7JFeJDJwlF3e+6WLyQWtqbh/GVlKnxTbtHCSp+avwwB32jNUNVdcB+m?=
 =?us-ascii?Q?DJgwM3Jwk9E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d4a7f2-5156-45bb-a14a-08d994f1d25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 00:20:58.5871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
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

[Public]

I will try it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, October 22, 2021 5:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy f=
lounder boards

Some navy flounder boards do not properly mark harvested VCN instances.  Fi=
x that here.

v2: use IP versions

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1743&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7Ca8087124988c4196bf8008d994dd00a9%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637704499192475535%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3D%2B96nBOC0y9B%2BKQKAPGQHXcOlbv3EhPtKK93tKIXI3do%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index dfb92f229748..814e9620fac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -507,6 +507,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device =
*adev)
 			break;
 		}
 	}
+	/* some IP discovery tables on Navy Flounder don't have this set correctl=
y */
+	if ((adev->ip_versions[UVD_HWIP][1] =3D=3D IP_VERSION(3, 0, 1)) &&
+	    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2)))
+		adev->vcn.harvest_config |=3D AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count =3D=3D adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;
--
2.31.1
