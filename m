Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D5C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 02:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE6A61056
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 02:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EE6A61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6CF6E9EA;
	Fri, 20 Aug 2021 02:02:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAA16E9EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 02:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN8mugjnBsbkFqHEaJB9yo1rWX0xF+ty30chekHFR9yGSD0NOmxdw7ZrcLLoAZt9T2sPzp7ZkMJuXEoAoDavd8glkQ2JPQtYIGBQeJRRCf4IGPahSVadKUwjNIVISIdg8DslGj7u8QZu7pTdqWbvhVIFzuZBBVUdruEg395d0238CF8ApK/6e021lTZesjqzDasVkgMH7N4sWT2NeNmWggnZehTLHR0lJg8zXdQMcJBVTLHXKsiM4YB3KFXDB3dn2Y/BebH1gqsc6n2OR/t0AukCmMBxy5HR3xGUE/n1M6I3kwaAmgX1TPD6+feiLpLTrJDhhfbzgYJRcznYdwrd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhneghIc1J6Ha9kkLct/ff7W8VFUPcZPXIiaLxK8Ugw=;
 b=GmLLtC85paeR+BSdrhUC3WnqewRxMeVRLI2r7zlkQEPsFZTpHOSmViWTcBV7zfhjwPbdu+iWb4JCX86lUF8jpDFJmSlVnQ+F9CVncvAp5r1SB+Ktbbeax/0EnJa6CbJ+P1BdShzahJRmdDBL7TINOhN+nHChX/OucyXuOlUU/6IgVEL1LG8iCLADLUjweFGCVroZmTX5j4rysy/Luw1ru2Q8NVACR6tqMvi+6gh66hnIWcHSvaNX/c6TVHdKwMvQlSpoznqP/w9bHymReQ3K6H3Pw9f8/J65QLef3w0QqsZtAeTTp4PzoZINGJol8TJthadvO+2Xnfbp/BoUqhbekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhneghIc1J6Ha9kkLct/ff7W8VFUPcZPXIiaLxK8Ugw=;
 b=wt47fRUr+Qu5neOgXRscmaGetcXIey7mZZe12vkwFF+DgbXKetbofBkyWg5w0kErT7agNRT26Io9Cn44fjP/zscjpJ5EqnrcQXJfvdjGVk2iElpC8u4JJ6In3L/HGcxF+2zOHoIquY1/E4ALs3Ycd4OHQtUwIoVDkGwvdbYiyHQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.21; Fri, 20 Aug 2021 02:02:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 02:02:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
 on suspend
Thread-Index: AQHXlKeZ3i91IyfmtkWpwlG7kjfTZKt64RiAgADEVBA=
Date: Fri, 20 Aug 2021 02:02:42 +0000
Message-ID: <DM6PR12MB261965FAF0DEA4AA9561A234E4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210819030859.1470753-1-evan.quan@amd.com>
 <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-20T02:02:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e50d8301-1629-4d96-70d7-08d9637e98cc
x-ms-traffictypediagnostic: DM5PR12MB1835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB183589FCE2976270ED0B742DE4C19@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fk9YCpEaVcetkbhJhzSVg7MMfMLQs7PslfEeubFY57VaaXec16MZK9supX/lMkQWMjchAtUuNV+0ppK2HZWkiC3do/3dSSYzwq9Mzm/XgBp34FsmZo9+nAdAPUoW9MWzwDSvWBtsRr6i6xGfmAVBeJ67BIxhw7uBLRxxN39d+dEyysL82Hh0Gocbk0BkUa4U1uPw5qxvNTFY3f/GnVOd0qN6MczdvS0s/52ap1o2d1gScqFzMk1Ctvt2791zPo0ZkiX8sqrwB5Wnxj4bPh2ljH3kUheOXmxRGR4qavpy+vCq3za795JyF8jlO2c2BEJD/y2Lj4nKxU88jMcpq41ViRsngX6PhGIOQW1iXjzRVr2NCTJE5557PUsW2TJaLykwmMXf7lcf3VJgjIQDNCEO8fW7aoiiOA4g1NNzaRzqduj13nr9Ms34wbPUaE720YITD10nOqH1lJYqrMqoVEryvBZDm/T3VBYwPPI4dshy07CtlSn7vBXliIXKwNV+YpdgXJBj7Ci278Ziy6s3uYw9T/sGTTGNwxJXlUmkANDnzyCUIapk6vrbQ/WrPNYPDiOs6KHWAwoIUNi7XYLUa0Jj7k9ERV1BvtLFTx5QZxT0OqzFG9E3D4hc1GtkaVokztmC8Lnle9bVs4Zkjnvz8GTUOlAlMixVKLXd7QU55wpuIaz9zS8RO/BQHPdCxehyrsg8ArprK9bh6i0RMS+BoUmBqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(33656002)(83380400001)(86362001)(52536014)(26005)(38070700005)(4326008)(316002)(53546011)(122000001)(6506007)(76116006)(8936002)(66476007)(66446008)(64756008)(478600001)(9686003)(2906002)(66556008)(66946007)(5660300002)(8676002)(186003)(15650500001)(110136005)(54906003)(38100700002)(71200400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?atLPKOf8LNgaUz2LWfqS8W9DIsPs6Tr6W4aqb2hWnAyLXn1XSv9tZRQoGvsi?=
 =?us-ascii?Q?xEZ0gpH0MbkurIPecrneyhtYqBxWczM9FSq49ZoLRCC2O6H6jpluWfTzTNRY?=
 =?us-ascii?Q?j/L6Id3xcthgu9w7hzYnX/TyyNYfqPigb+G9sXGyHnK8Smv9iBTUeabrbC7k?=
 =?us-ascii?Q?1smZ0RtM1zEJe64uZ2fx7OseMciYDiAa9dvV9kSoR3XGbNhIryaIUzlB1HDs?=
 =?us-ascii?Q?DJ4oHtFdkv+4SGJj4hoelAxKIb+B0Ry3MQTid+nNk625n0l9onW/b57MHC6z?=
 =?us-ascii?Q?2W1WCoW/qXjyr0HpJObWUxRaZMeHK5OsTTPNjbc2+3ooqxrRO7TSFXND5loi?=
 =?us-ascii?Q?NNYCrThcWybRiz0CGcqX68vNHNp1WX5PWBvvZayZIt5kHTdykczSOTeEx5rr?=
 =?us-ascii?Q?t8O6SKU4fVKVKv3dmpniJT/yFt+/2cAFvUuUQp4pbqGceA5PoLJ31Y+SRYr2?=
 =?us-ascii?Q?Gc8uRQ035gg8zshLEPWmqiOZnxJa0lknz+at4l+QOEPTITrgJ4elbWyUaY1R?=
 =?us-ascii?Q?7XdXSuQHrlxWHC+ieRZE9yOWtBsT8JBOSfF++f3clZVq0e6PDFZimDiwvb1A?=
 =?us-ascii?Q?2Ka1LbkB5+QChttPeSDVDKa7y+6MNi/2A3MObe4m3hrApeUwS7M/gOrLCA0I?=
 =?us-ascii?Q?DwJInbFgYuXI7Kwv+QAysunBIs2fGxo7wdruQ6fC1ra6vo88R+IubYob1eXj?=
 =?us-ascii?Q?LILNx3d87lowQGuaJhogX1yK5Dqezo+L2aiyxRMwWBDqGnvhQmXVetI2jrnv?=
 =?us-ascii?Q?kVRxmweM5dnvkVVprpy0nN3fzY89IifeAuJ9HmgykzQ/vPc3lrorcDbewbfL?=
 =?us-ascii?Q?O79FafYBcwwvUytJ1GAjJ6Egs0AylVhK2Zp+BjGYY2JXZ9tni7t067OCh9sl?=
 =?us-ascii?Q?B4p9kXcEXBsdH9dvkpZT4Xfgq8Th5tjQD4EqP/cie+aMg608WQJl0vlCB1pi?=
 =?us-ascii?Q?MpXxXT55wh6jYl+SkCk4mbP+rkeFNYmTfqvB/LvzFhsoyCp4Jfm0qi5cKnlq?=
 =?us-ascii?Q?UMSllXkqG08UX/I3305p3LyKA6uahIJcRTz3HkcexUZVm3sU7C6HZ7FvePg2?=
 =?us-ascii?Q?OOgzk6CKY13W7dQgy5YlDOUq2Rup0PGGgD854XGcLfbstlRLK/DwAX5dUbmZ?=
 =?us-ascii?Q?MKB8XIM/Ob/UMGharqXd/DhMrSVstrbm4PrAoAsxg8sD66Kz3zosLfqC+rid?=
 =?us-ascii?Q?JjHfXImYQURY0FKYXUNgVQH3Ri7XW+tWwlHG1mWTPJWWwdSqrwFY7YuanDwr?=
 =?us-ascii?Q?KhTII5LLzUUrz+Q/6EM+9XCmxSeNm76pbi1mP4EaUIjWtIBNGMY9lqr4KSEw?=
 =?us-ascii?Q?OOpE6hZcNPifX2jCiR79DS5x?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB261965FAF0DEA4AA9561A234E4C19DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d8301-1629-4d96-70d7-08d9637e98cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 02:02:42.8690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7f95yFz8KWWJ6eN4t3VVv7Tm0VXzhwoEu7JLw4PjiVfpNaVSEC4lvY8C7y5q9Xzn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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

--_000_DM6PR12MB261965FAF0DEA4AA9561A234E4C19DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



From: Zhu, James <James.Zhu@amd.com>
Sent: Thursday, August 19, 2021 10:19 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.=
com>
Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE=
 on suspend


[AMD Official Use Only]


Why not move changes into hw_fini?
[Quan, Evan] Sure, I can do that. Will send out a new patch with that updat=
ed.

BR
Evan


Best Regards!



James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan@amd.com<mailto:e=
van.quan@amd.com>>
Sent: Wednesday, August 18, 2021 11:08 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; =
Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Quan, Evan <Ev=
an.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Pan, Xinhui <Xinhui.Pan@amd.com=
<mailto:Xinhui.Pan@amd.com>>
Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on =
suspend

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
Signed-off-by: xinhui pan <xinhui.pan@amd.com<mailto:xinhui.pan@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 4eebf973a065..d0fc6ec18c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_uvd(adev, false);
+       } else {
+               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+               /* shutdown the UVD block */
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_UVD,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D uvd_v6_0_hw_fini(adev);
         if (r)
                 return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 6d9108fa22e0..a594ade5d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
         int r;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       /*
+        * Proper cleanups before halting the HW engine:
+        *   - cancel the delayed idle work
+        *   - enable powergating
+        *   - enable clockgating
+        *   - disable dpm
+        *
+        * TODO: to align with the VCN implementation, move the
+        * jobs for clockgating/powergating/dpm setting to
+        * ->set_powergating_state().
+        */
+       cancel_delayed_work_sync(&adev->vce.idle_work);
+
+       if (adev->pm.dpm_enabled) {
+               amdgpu_dpm_enable_vce(adev, false);
+       } else {
+               amdgpu_asic_set_vce_clocks(adev, 0, 0);
+               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_PG_STATE_GATE);
+               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_T=
YPE_VCE,
+                                                      AMD_CG_STATE_GATE);
+       }
+
         r =3D vce_v3_0_hw_fini(adev);
         if (r)
                 return r;
--
2.29.0

--_000_DM6PR12MB261965FAF0DEA4AA9561A234E4C19DM6PR12MB2619namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhu, James &lt;James.Zhu@amd.com&gt; <b=
r>
<b>Sent:</b> Thursday, August 19, 2021 10:19 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Pan=
, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 =
UVD/VCE on suspend<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Why not=
 move changes into</span><span style=3D"color:black"> hw_fini?<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><b><i>[Quan, Evan] Sure, I can do that. Will send ou=
t a new patch with that updated.<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i><o:p>&nbsp;</o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>BR<o:p></o:p></i></b></p>
<p class=3D"MsoNormal"><b><i>Evan</i></b><o:p></o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Best Regards!<o:p></o:p></s=
pan></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">James Zhu<o:p></o:p></span>=
</p>
</div>
</div>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&=
gt;<br>
<b>Sent:</b> Wednesday, August 18, 2021 11:08 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:G=
uchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D=
"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&=
gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com">Xinhui.Pan@amd.c=
om</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/=
VCE on suspend</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Perform proper cleanu=
ps on UVD/VCE suspend: powergate enablement,<br>
clockgating enablement and dpm disablement. This can fix some hangs<br>
observed on suspending when UVD/VCE still using(e.g. issue<br>
&quot;pm-suspend&quot; when video is still playing).<br>
<br>
Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan=
@amd.com</a>&gt;<br>
Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan@amd.com">xinhui.=
pan@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++<br=
>
&nbsp;2 files changed, 47 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c<br>
index 4eebf973a065..d0fc6ec18c29 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;uvd.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_uvd(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_uvd_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* shutdown the UVD block */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_U=
VD,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v6_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 6d9108fa22e0..a594ade5d30a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before haltin=
g the HW engine:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the dela=
yed idle work<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgat=
ing<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN i=
mplementation, move the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergat=
ing/dpm setting to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&g=
t;vce.idle_work);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_enable_vce(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_asic_set_vce_clocks(adev, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_V=
CE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_hw_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
-- <br>
2.29.0<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB261965FAF0DEA4AA9561A234E4C19DM6PR12MB2619namp_--
