Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68651C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 09:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066036EAE3;
	Thu,  2 Dec 2021 09:19:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A406D6EAE3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 09:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+d5KSw9ehY5tp4a4xJ/8VKj4AyyLOr/zYPECU175/7k3/fLzr9wL/LY65bA4NZwS7PaLwmCKK/JvTuLHi4veHzOmSAwt2M4Nr3AseCzIL4x8avNOGw4r0LsrjXfjfnkfaJQlBB84ZSw/5usrNLmsxXh+TnwN2pGwEpSKEd+rklB9JYp/Q7bBsTFb7ehy9SbZaz/wHSKh2AK7LbWFDvDFEDP2C6vfAGc+3or0nz4n5BZXNSBuEcUXKJdTNTa7AUvjOdoVi5KV7p1SKNLrceyztGn7IVhwaq5MWFEnhdpwQHB6tT3GyEPvcCbrDMIFOQBHkiVfOGUwhNxkwT/LPry9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if9VGVP/JYQyPsdhm8Spl7BBqjNiv/N2sbdzyNQCAbc=;
 b=h6OoKDfW2jtDAPqc9p1UGoi5mw047U21J44cCrvvlj0LIWz5BtzuImlGdDbCPpgJw9bAfTBm/hH6NvGEp8FNgskRCGqDCkBD/EAQWFaNN5ExewWidZksTjSvjNZBMxlel3xKilO+kqehLSSfP0ge82B2l4M9EfZXk44TyGRtmLgCm2TUIrNmeiiT2RpF7kP7uwdYZCCa2x3dswc+f5eUCxRPuYjRcuLPkGUH1g54vBubGzgt+7MFXszwT6RSl13WYuNxV49cEaTN2I/PwIGY4t+WbwxVeRy1cXA61lYAE/4SERwhkC/zxZlfiTVQse8iTFgX7NfdwIUGtQDcn4m+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if9VGVP/JYQyPsdhm8Spl7BBqjNiv/N2sbdzyNQCAbc=;
 b=LKAAZTrclQi/OmKoTK9IzkdH44Cig4g0Tk7S9dFxH/3Jgx0ZdkuA/TwwkpFwtZVKOVViNDGzsibRlpwY2B9yY/BwZiYTEeXAJRabe+PoiiwMHFcpArXFCKdkrOPK+wsmhOEG/zEHxtRiS7ScXegYErXxE+mJxf+LDS+mxTintyE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 09:19:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.029; Thu, 2 Dec 2021
 09:19:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/2] drm/amdgpu: skip query ecc info in gpu recovery
Thread-Topic: [PATCH Review 1/2] drm/amdgpu: skip query ecc info in gpu
 recovery
Thread-Index: AQHX51LU25o6f+A6Rk2Yj0USqcOWoqwe7Itw
Date: Thu, 2 Dec 2021 09:19:02 +0000
Message-ID: <BN9PR12MB5257697D2F1E066094AF1B3CFC699@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211202080130.22503-1-Stanley.Yang@amd.com>
In-Reply-To: <20211202080130.22503-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-02T09:19:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1c37d7a6-17b8-4e17-8ff0-ba903d7185f0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5a01b6c-5ba3-40cb-89cb-08d9b574c864
x-ms-traffictypediagnostic: BN9PR12MB5068:
x-microsoft-antispam-prvs: <BN9PR12MB50689A2C241BFF3E3080C03AFC699@BN9PR12MB5068.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaCginWtZHDA3aTrOwbuu16XeGKrSCVMjfnRvaKu5S7pbssh5cv0OiaJm4J3ZJN91t5QyabEcVjomaVyLd1XSJ/vC1+5V6SMKYy2r23p7aR3nX41shDJfmqG6QuF4FLPein1nS3GVf14ZpjmWARV6dUyvI9C3SGaSVyIi+sKEuPvsNLpQNl3Xg2WBPcEO/PBUsIxh4nXXDIt8G7a1aP0+WqrJzA+bmquBNGC7/OK/xYFvxsr/0WLabk3E/RXYSb14GLFzOdZl9xQDEsneA7eWeI+GM+6HLbrxWzm6soWcy6RrqebNBbH7RQVJiSRoV+LBfTbboH8rpKTphKn/wTKqRBUjNwioO+9EdQ3y6Q4pTtCYwZBIdZQcqjFpO5hye9gnLU21cWY8du2xgUSsvTqBJPbC7IMNeA6jDppZ0gILwKXAL/1AfJ4ItqhgDHVGx3QrNkhCShRzFihkTWPOJbC6mNvTrSFqWjmzSRAYR65WUl9DfG8SbA+S0Umg7shMwRd1drlOBDBRyXH3H4VKRgHl5Psd+RTjGR4F51zK8Uk+3081Tvr4RfblPJkAEyFe6rhuT3RYayTmeMJYWPZNAQ9mWbanZNffvh9Pv5A1o4djf4qZiUxv8Jq8BWOoxnJkaUeE2HVFWrWGGnCLGdIWz0ktAW6X0EEfIE93eehHvtChsdOiPvjM9bF60aEbjdAhdYIy7G7xuKGITt0c8hKryHA1asgxi4GqEizNK6M9POFrhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(55016003)(110136005)(66476007)(66946007)(38100700002)(8936002)(9686003)(5660300002)(66556008)(6506007)(8676002)(7696005)(2906002)(921005)(6636002)(64756008)(83380400001)(26005)(66446008)(71200400001)(508600001)(4326008)(122000001)(316002)(52536014)(53546011)(186003)(33656002)(76116006)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fAq3KqtlNZbVrC1UK1HfVNUEkLb66SOZFXnEdFtYUpqVN21fjTOwh2mdLb9T?=
 =?us-ascii?Q?y/mC8w92Lkr5JGyjU9JOWos5TfBAHTUtZyGMXOHF9K0d7t0sG1DeHNSdPrHc?=
 =?us-ascii?Q?w9ITBDgmX4dfQ45twy7hI6XjD8JyADQO6I73Tl5J59VR8om3BWz9RlSRPpPW?=
 =?us-ascii?Q?p51DgQCjk43dXV05rYyPqCy4JgeXeek1mLYIBSYcaPDlqf87Re7luHTxUFTo?=
 =?us-ascii?Q?MYLo52t4gyPIDZ5Oy0AcJqjo8FdXljmhJ4sVUTaVray2ev9EsOvHLEgAj2Yc?=
 =?us-ascii?Q?sDeePs6xcJ9iEWfFqLBjbtyA3Q3qEhuEr77QMGHBRNRXO2y2DH0Q3TmUh937?=
 =?us-ascii?Q?li8le3TJmcAtTvjFpBv7gYwTVyOdxpfKwh8w45p/BH6wD1UK2m5XUksdP5Og?=
 =?us-ascii?Q?kpI8n6aCgVQUDtutHOV4iw2OKCZBVFXKxkjwh3v0tVrqiimem1QZBGJSndXl?=
 =?us-ascii?Q?U5EiD1x2/U5r/k2m4s1Tkeu9uRRPTytFjflBPfsIzxpDKe0+BuOMcZVQfaMj?=
 =?us-ascii?Q?cx+Wh5xC0W2iqCujBNlmHn7xMwwymzmpVcUT5KlaOII4NtVAs9A9D5hrooaZ?=
 =?us-ascii?Q?YmZc9mwAcK6SaLlNiGz2ZOTPYrJDN5lMJS/HLTriEiKpRjiKv5f2woUMUZdt?=
 =?us-ascii?Q?LS2YwShsLVIDUfZ/ddIMX1O/H9vqQ/A6GfwKgczkGS+fDr77RPRp+7wZmEMq?=
 =?us-ascii?Q?mC7ccJUV7j0+7v2dlyCzz+ldNNAGAC4GcbXHCl1MVsNHtLX26rNe2TNjuQfo?=
 =?us-ascii?Q?e/EjmF3X//Rfo8c7SXsv0/XTJ6UET9pXj7MBMi6JJeY9/9Q1XkABbWTukqqA?=
 =?us-ascii?Q?D6sRK269VbPAaY6egd/K4EG34q0e+oyYMPDC1J+H5pWuE4SGIniqStI2eyll?=
 =?us-ascii?Q?rWAv/IMMAXN+cl1u42fRMwyIFNxEd3h3orLL0jXADOEp5bJnde7gGCaXcXrx?=
 =?us-ascii?Q?VH/KlslueVlH9vZ8UmY4kY6zlzxJZsffkkk0jWb+ufTj6lFbaFzojZ8vOmzR?=
 =?us-ascii?Q?hNOs0BDwtm56fVX4YFhOt9wAsgu2qhJCMGnzlnvlREa0CrTGNk/eS7glkc5p?=
 =?us-ascii?Q?KqvpKO1I8q1n2aaWCOqwn5PGpY6k5fqsirS+/zAn2tcoebYZiALWVhEjMMf+?=
 =?us-ascii?Q?+mVYC7sQUvFPa+3tDl6f9MOo1+o9AyCc27Esdj6RUhmsquKDpUNNCInYe/eb?=
 =?us-ascii?Q?V4RdOUeK7CUpbt1RbVYZI0I3sm29qiP1A74tfHgcoxbFjSKYKNbf0KgR8qA6?=
 =?us-ascii?Q?Km/HrzHJRKsu4zseCWj6CgTD0+8ib08IoiRersbc5B/65v01drAihDgznhg2?=
 =?us-ascii?Q?FNGAachfQx2YPWrQsew6lQ2rd0XcuGzO8yoEqMvc7v4RxejgdrkSdB5xhArm?=
 =?us-ascii?Q?VOYSsKPpmuOF/QMvfIMfmTDMZksAlh/QG76Ck9XQTp8aO5GeJNkGcKICLrv9?=
 =?us-ascii?Q?VyskrLUM4sz7r3vnjgiC7GsUrKrHl29PaXRRDIyqZB9i7e/U7f2w9V1UFyk5?=
 =?us-ascii?Q?eoQk8mpfti5T3cLpPNDnPNYSlMXBuBcg1ZFznSNGGy/tSraPyWiTzosYSrbX?=
 =?us-ascii?Q?CKTHkdJfAlix/OWpT3uMXSLH5RnC2gAFXn39RUDA4QMiV65FX/PRszG5zddc?=
 =?us-ascii?Q?giKyGmtlT4Xf/UVU6a++P4M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a01b6c-5ba3-40cb-89cb-08d9b574c864
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 09:19:02.9494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6GfbD3y+qLrqJwejzjhGo6K4tcrvwmYObR/biWx4KOpTYnRILBcZq1+JRQMChFX0jY+cbNgDH/yILh++xk8vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Thursday, December 2, 2021 16:02
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu: skip query ecc info in gpu recovery

this is a workaround due to get ecc info failed during gpu recovery

[  700.236122] amdgpu 0000:09:00.0: amdgpu: Failed to export SMU ecc table!
[  700.236128] amdgpu 0000:09:00.0: amdgpu: GPU reset begin!
[  704.331171] amdgpu: qcm fence wait loop timeout expired [  704.331194] a=
mdgpu: The cp might be in an unrecoverable state due to an unsuccessful que=
ues preemption [  704.332445] amdgpu 0000:09:00.0: amdgpu: GPU reset begin!
[  704.332448] amdgpu 0000:09:00.0: amdgpu: Bailing on TDR for s_job:ffffff=
ffffffffff, as another already in progress [  704.332456] amdgpu: Pasid 0x8=
000 destroy queue 0 failed, ret -62 [  710.360924] amdgpu 0000:09:00.0: amd=
gpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000013=
 SMN_C2PMSG_82:0x00000007 [  710.360964] amdgpu 0000:09:00.0: amdgpu: Faile=
d to disable smu features.
[  710.361002] amdgpu 0000:09:00.0: amdgpu: Fail to disable dpm features!
[  710.361014] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspe=
nd of IP block <smu> failed -62

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 33fa1f619926..641f9b447997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -895,6 +895,10 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_devi=
ce *adev, struct ras_err_d
 	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
 	int ret =3D 0;
=20
+	/* skip get ecc info during gpu recovery */
+	if (atomic_read(&ras->in_recovery) =3D=3D 1)
+		return;
+
 	/*
 	 * choosing right query method according to
 	 * whether smu support query error information
--
2.17.1
