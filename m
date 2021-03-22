Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6ADC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DEF61927
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 06:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DEF61927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545FF6E0AB;
	Mon, 22 Mar 2021 06:02:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC956E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 06:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7bqEW/eeEPeR7pShA0RZv8QQAQZN5wjCYnD6HSVIfwGJFfUG6sHTMfC+L0ULUtvt+2E/p9xAtPUSlKy6/U9CZyff9ITh3K7l4ScG4gXtgkAQqpwUYPgBXEGApfpq1RW5xLmAiI+58hGj6U8kDOQBsAYCkTKr1PoypLGXQ+OgiZzpZkl8AKV2TThoIVJl1WgRCeksQc/wa638oW626TYdMxZHtuG/JYbU5PVT2sWMo83HTq1nm0/Ur49IUVqFj3XkWX6s3fiJnYIC/ePo0eEWVZG2NRHNxoQH3XqCTx7kjhcdTSlYWbOHCY9TEjHL/6v+vreIcttNBalSlqMrfvDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T6Aln+hCF5/Ct9Ktk0xXvaijeZWouvarIRmLeDYU84=;
 b=RI4pMtrnzzsdUCyr4qTEyHQE8TYtMa63l0nKa8hslTmnjFFldjyAwwO1VIQmcjMh32pfUpCITUvz4yn7ZfUsbe2KKPYZvnBn7tmo176SfdFDi8nAFq5oJRoR75Cz6lTCdytU/G1F3KEvk02uWMKqkA51jeiW7uYpNd9F/Iz6jLv8UCV3/fEx1CseqH1vbdSUr54jD/YdKjS0bUaERkn3UkhPsP1is08ujznceV7WVnIaVYI+L+TsRHoSFK3NpDuKVzIjHydZPVeCiuUfZX2cOvy4DcvB+nHeKV6xuhGL03d6hgdbxsg6XfrLFOQ4ivBo8koJwi/HHbB2R57xIFNFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T6Aln+hCF5/Ct9Ktk0xXvaijeZWouvarIRmLeDYU84=;
 b=jZgEK8tDJExTFil0E8C9iXlN8i1vz+crf08d3nSjqBWNSj5G+BufVXSGmF/PVYjKD/pwk6qh771Dwep+vxfYBis/Fu/7lkxb3F12qsfZdLLDoyKfTwHeg2OVlcsEywavNxzQFCtbNdx7LROn06kVm/deT/hQzH8CBJnKtPtH+JY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4828.namprd12.prod.outlook.com (2603:10b6:5:1f8::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 06:02:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 06:02:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not
 runpm capable is chosen
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not
 runpm capable is chosen
Thread-Index: AQHXHJ/+bn4BJbVYaU6ugyCV+OLbhKqLLE+AgABZAACABAEXEA==
Date: Mon, 22 Mar 2021 06:02:12 +0000
Message-ID: <DM6PR12MB261959C043B7ABB46EE3C012E4659@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210319091155.537787-1-evan.quan@amd.com>
 <20210319091155.537787-2-evan.quan@amd.com>,
 <MN2PR12MB45492A307D0D53E9ED04F1F197689@MN2PR12MB4549.namprd12.prod.outlook.com>
 <MW3PR12MB4491B515900092DED297EBC7F7689@MW3PR12MB4491.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4491B515900092DED297EBC7F7689@MW3PR12MB4491.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T06:02:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21c42425-ad16-4ccb-294c-08d8ecf80a0b
x-ms-traffictypediagnostic: DM6PR12MB4828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB482836ABC28AFEB685F03BB7E4659@DM6PR12MB4828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blmLMbxTZudNHP0vjlJ4AR114PHpnw/IXsZLY/tsWErb1xTjx6Lkbz+G+HlJgVW+zdtvWQFN4sxdzB3d/LJugakJ49ps54Ukjn9I83KJNjV8I9wTLiJrHLFPO0aXsGUbgSAif7xujaYqU0g2zkgM1PYWbVFy/GfHDRmWRrMZhE/yvPdDeS9LKKgywTn7hIvjCFfeIAvMT6RpJB9JuemWVv8PDihKHq/CDihjXcKmUZHLL+EDSZxyDPEumIxJOV7gH06xj8uUsMlD0Pg+5YRti/WRpADOMdYrGB6RWK80LVFSoE3Kst1qjFq44/ulsyghGfhg0WzPIHIiAKczZDPoS6PoS65+BQwomOgnlPmZnkTG4GB+JS5eWmiCq/wq4Yl5v87iP9Qn0GRb/A/zyTH3tJZx3M3VD3DunxgapF5xGGqTX6EvVjfL2tDc0KecJWFvyDHuYfOygBUS+JU6o/oaYhgEYWBk39NSp3vsYRU7tEKLU+nnPRjc8occvdp2Md+Flb6hx9T56j19LmpXQqUA42ER5Pga2re0gNOgwvxF9qN6T5JQmFEkAEpv4Oy6FqfjspmdGnNQqktKFEs1Zifw0CvLlUyyWLxviIBbkBEJb0jXs4+zTuREo1+jAxSUV4Wdq4YJWKEO2vJQCRdcNLbWytJFq6YDtwk6m6BE34/ffMUhjp/rYZ+oZPF/1fd0srv0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(5660300002)(64756008)(66446008)(66556008)(52536014)(76116006)(66476007)(9686003)(316002)(2906002)(53546011)(7696005)(478600001)(55016002)(166002)(6506007)(86362001)(66946007)(38100700001)(966005)(110136005)(8936002)(26005)(186003)(33656002)(83380400001)(71200400001)(45080400002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?erJ5u6PaqODwxMp5sZH0674MQqZzHjSm6mq3USMIv4uxcCmh1oiSPT0F3cIR?=
 =?us-ascii?Q?pzqTejTWlCwXa1Zyj2TEB6AKpXg7XcyZdIpwVCeRqlBKS/lyriT/oRDVmJf7?=
 =?us-ascii?Q?0faS2Z6AKRUQ3jHvQShZRvdHqT3hwk8hb+EaIX2ihJnvGhuaqDbJN8ZzZbjZ?=
 =?us-ascii?Q?baPrbQIQjrOWH/91GPZX2sR/L6FsiHCzWUyY2+k7Da6t6PunNPaX1Ut80zWq?=
 =?us-ascii?Q?qpggaHqTtcW1M13tm2Hrp078k6tiGUBP8Sofi+45hO9znjkdm196mC/3K/Gm?=
 =?us-ascii?Q?RGaWeHE/DymaD5YZDydsGG4dwezHgTbICa/oAccdPnLFeGH2nwXvTB+g2SQM?=
 =?us-ascii?Q?ROdi+E9CUoPD8IEqz+b6/B/ByrHzWvOdAXm9/6z/WhXKRVDEDHbDDlUcKcbg?=
 =?us-ascii?Q?iF9sjvZ88rCK3cmgOOg4RsvYhLfj3DQEAv8ZBXSQ7tdX5Gr2x6SUb3STdNVo?=
 =?us-ascii?Q?iTBuL9GIQYa+kgb75V9KGdizF9OmlWfUxqiewknhOsJcD7BR0KIztXG3M+to?=
 =?us-ascii?Q?YDYswh6ncM+H9hK1Bn1U9GrapQk1XNvpFLzG5wJj/m7nY/KTMHW+HhAAGItB?=
 =?us-ascii?Q?FeYCXwdaCe0kBZDHC29/C/Tbn/cREIF4wkKp3a6vXkQ4h0kAl9sk9PYcyzfM?=
 =?us-ascii?Q?vYNOij7Uu9VCvf/KmggQ4V3MVshr0D63y0aIO2/DYEPMQpXWZpUSbesGOGHz?=
 =?us-ascii?Q?bxj0c7tGbNb8g7XUxN4XvMXwPSRr9gqLxYucVgw+FvXV8Ybz10QFJKYNLPVx?=
 =?us-ascii?Q?qnxvSUPE9okqbmqPEhn+hFcv0d6v/SbP1kbBJqVEhW4Wxb56bqNCpRn2UuV8?=
 =?us-ascii?Q?KoNjsxCeeyY/JZIRICheX6kShEIKs/G0GJm/cVewl/vmagE5XUFTnlW04XXq?=
 =?us-ascii?Q?hoHK5hUgRUJtzzaOs2hfG20Z5piwHMHyHY/C4Rar+dOtGbpWVYWVl/6Yveeb?=
 =?us-ascii?Q?OBvhp8oc6SeIV6zCYMuUqupSJghgUqPICHKo+u5yi3c42WexhfnC2c9AFxKz?=
 =?us-ascii?Q?5EjkFeflL0hW+Mw2n+TKOieNqsvz2nz3O1zAF5SSZZqBJQ2PJTnVgVP+qYG0?=
 =?us-ascii?Q?Qfw8HNiOumN29BczHdVYSTdgNc9xn9N/5BuYWCmxMF8fnDF0DuWS7UDSpbds?=
 =?us-ascii?Q?529Y4Cg/ap+LHXk5NmmRtZwJ1kOKV+GmVRxLrl+pAe38sg3NOYdd8c0mc6VG?=
 =?us-ascii?Q?HMDwcii0qd9hdZzy/JyxzaEkRZo+isplujjT0Jfp9D1NXhhFgifDxUsQMbtj?=
 =?us-ascii?Q?wkcZSOvKLH+s3cnztxTDCFLFo/bcxLZs5L0akstg0XyzXDD0Cy0b6/OFVy1e?=
 =?us-ascii?Q?Q0BAA9y1vIEk4R5j004jq3PE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c42425-ad16-4ccb-294c-08d8ecf80a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 06:02:12.1952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4xcT7B0kRE667u0Ir+p4XNc8bjnsIqrYXFT+KH+7StK4E5qloz9DB3liuDdFquv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4828
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
Content-Type: multipart/mixed; boundary="===============0089026078=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0089026078==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB261959C043B7ABB46EE3C012E4659DM6PR12MB2619namp_"

--_000_DM6PR12MB261959C043B7ABB46EE3C012E4659DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks Alex. Yes, you are right. BACO is used as a power saving feature for=
 runpm. I missed that.
I wrongly treated BACO as a reset method only which cannot be used with mod=
e1 reset at the same time.
Please ignore this patch.

BR
Evan
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Saturday, March 20, 2021 12:46 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-g=
fx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method no=
t runpm capable is chosen


[AMD Public Use]

Yeah, the reset method is independent of whether we can use BACO for runtim=
e PM.  We can use BACO for power saving and use mode1 for reset.  Is there =
some issue I'm missing?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Lazar, Lijo <Lijo.Lazar@amd.com<mailt=
o:Lijo.Lazar@amd.com>>
Sent: Friday, March 19, 2021 7:27 AM
To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method no=
t runpm capable is chosen

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Evan Quan
Sent: Friday, March 19, 2021 2:42 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not ru=
npm capable is chosen

Otherwise, the runpm will be always enabled on a BACO capable target even t=
he reset method was forced as like mode1.

Change-Id: If6bf55c533e91470c9c83383788466161608f68d
Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/amdgpu_kms.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c         | 2 +-
 8 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 963ecfd84347..be12dd2550b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -589,6 +589,7 @@ struct amdgpu_allowed_register_entry {  };

 enum amd_reset_method {
+       AMD_RESET_METHOD_AUTO =3D -1,
         AMD_RESET_METHOD_LEGACY =3D 0,
         AMD_RESET_METHOD_MODE0,
         AMD_RESET_METHOD_MODE1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 6a06234dbcad..78e5445b28b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -168,7 +168,7 @@ int amdgpu_noretry =3D -1;  int amdgpu_force_asic_type =
=3D -1;  int amdgpu_tmz =3D -1; /* auto */  uint amdgpu_freesync_vid_mode; =
-int amdgpu_reset_method =3D -1; /* auto */
+int amdgpu_reset_method =3D AMD_RESET_METHOD_AUTO; /* auto */
 int amdgpu_num_kcq =3D -1;

 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work=
); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_kms.c
index 8844f650b17f..49068ad698a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -168,6 +168,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, =
unsigned long flags)
                 adev->runpm =3D true;
                 dev_info(adev->dev, "Using BOCO for runtime pm\n");
         } else if (amdgpu_device_supports_baco(dev) &&
+                  (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_AUTO ||
+                   amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO) &&

< > Why to link runpm suspend method with reset method?

Thanks,
Lijo
                    (amdgpu_runtime_pm !=3D 0)) {
                 switch (adev->asic_type) {
                 case CHIP_VEGA20:
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c
index c0fcc41ee574..e671871f4d28 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1395,7 +1395,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
                 return amdgpu_reset_method;

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset:%d isn't supported, u=
sing AUTO instead.\n",
                                   amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 2670ae00c2e5..1e751d415f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,7 +529,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_PCI)
                 return amdgpu_reset_method;

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/s=
i.c index 7cbc2bb03bc6..b9db761a7cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1420,7 +1420,7 @@ si_asic_reset_method(struct amdgpu_device *adev)
         if (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_PCI)
                 return amdgpu_reset_method;
         else if (amdgpu_reset_method !=3D AMD_RESET_METHOD_LEGACY &&
-                amdgpu_reset_method !=3D -1)
+                amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                          amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c354a11e2fd9..ad11f2e1f4db 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -689,7 +689,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
                 return amdgpu_reset_method;
         }

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index ea338de5818a..6b380a25e22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -895,7 +895,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
             amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
                 return amdgpu_reset_method;

-       if (amdgpu_reset_method !=3D -1)
+       if (amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp;reserved=3D0

--_000_DM6PR12MB261959C043B7ABB46EE3C012E4659DM6PR12MB2619namp_
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Alex. Yes, you are right. BACO is used as a p=
ower saving feature for runpm. I missed that.<o:p></o:p></p>
<p class=3D"MsoNormal">I wrongly treated BACO as a reset method only which =
cannot be used with mode1 reset at the same time.<o:p></o:p></p>
<p class=3D"MsoNormal">Please ignore this patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Saturday, March 20, 2021 12:46 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan=
@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: disable runpm if other reset me=
thod not runpm capable is chosen<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Yeah, t=
he reset method is independent of whether we can use BACO for runtime PM.&n=
bsp; We can use BACO for power saving and use mode1 for reset.&nbsp; Is the=
re some issue I'm missing?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com<=
/a>&gt;<br>
<b>Sent:</b> Friday, March 19, 2021 7:27 AM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: disable runpm if other reset me=
thod not runpm capable is chosen</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Evan Quan<br>
Sent: Friday, March 19, 2021 2:42 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</=
a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not ru=
npm capable is chosen<br>
<br>
Otherwise, the runpm will be always enabled on a BACO capable target even t=
he reset method was forced as like mode1.<br>
<br>
Change-Id: If6bf55c533e91470c9c83383788466161608f68d<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-&nbsp; drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/si.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 =
+-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 +-<br>
&nbsp;8 files changed, 9 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 963ecfd84347..be12dd2550b8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -589,6 +589,7 @@ struct amdgpu_allowed_register_entry {&nbsp; };<br>
&nbsp;<br>
&nbsp;enum amd_reset_method {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_AUTO =3D -1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_LEGACY =
=3D 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_MODE0,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_MODE1,<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 6a06234dbcad..78e5445b28b5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -168,7 +168,7 @@ int amdgpu_noretry =3D -1;&nbsp; int amdgpu_force_asic_=
type =3D -1;&nbsp; int amdgpu_tmz =3D -1; /* auto */&nbsp; uint amdgpu_free=
sync_vid_mode; -int amdgpu_reset_method =3D -1; /* auto */<br>
+int amdgpu_reset_method =3D AMD_RESET_METHOD_AUTO; /* auto */<br>
&nbsp;int amdgpu_num_kcq =3D -1;<br>
&nbsp;<br>
&nbsp;static void amdgpu_drv_delayed_reset_work_handler(struct work_struct =
*work); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_kms.c<br>
index 8844f650b17f..49068ad698a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -168,6 +168,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, =
unsigned long flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;runpm =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Using BOCO for runtime p=
m\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_device_s=
upports_baco(dev) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_A=
UTO ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method =3D=3D AMD_RESET_MET=
HOD_BACO) &amp;&amp;<br>
<br>
&lt; &gt; Why to link runpm suspend method with reset method?<br>
<br>
Thanks,<br>
Lijo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_runtime_pm !=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/=
cik.c<br>
index c0fcc41ee574..e671871f4d28 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c<br>
@@ -1395,7 +1395,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset:%d isn't=
 supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 2670ae00c2e5..1e751d415f15 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -529,7 +529,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_PCI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/s=
i.c index 7cbc2bb03bc6..b9db761a7cc5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/si.c<br>
@@ -1420,7 +1420,7 @@ si_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method =
=3D=3D AMD_RESET_METHOD_PCI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_reset_meth=
od !=3D AMD_RESET_METHOD_LEGACY &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_reset_method !=3D AMD_RESET_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 amdgpu_reset_method);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index c354a11e2fd9..ad11f2e1f4db 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -689,7 +689,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index ea338de5818a..6b380a25e22e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -895,7 +895,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_reset_method;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D -1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_reset_method !=3D AMD_RESE=
T_METHOD_AUTO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
--<br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9ed=
bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BR=
Q%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9edbc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BRQ%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C5cacb7cb280c4055647a08d8eac9ed=
bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517500293380275%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3D93jzFipkAGazXCqwfxbKUkvTDUHmuSZT6cNAcymg%2BR=
Q%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB261959C043B7ABB46EE3C012E4659DM6PR12MB2619namp_--

--===============0089026078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0089026078==--
