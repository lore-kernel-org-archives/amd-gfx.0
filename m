Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 18:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C87510E1B2;
	Fri, 21 Jan 2022 18:49:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2B110E1B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 18:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwLzpZEYNKM4nioY3daTAwGiScoZMDm0PYWAPp6dd7TciEJtLpJCDCilvBZoGmJYLi/tmW45zA7zj2W2rzxxSYVrtxmy/hrvtEgBW5uUfL+erPyI+uRfoqQx/WMHysg6vJSPmRhEPGHjagphMsRWi2AXNrNk0gmaskC5Naor171UbzM1dji6W3mmsPwSO/Zm/nemkc813eLl4QOCF0eGbJpHQ5QkYPImp1C8i5A//v1o1xLnyXzFvccSv2Vz+62z8u7H+eaEXCKd3yUuxUktp7MahpHEAJVSQ+ZsBJDmSp8HDj1VUKpS2lw8/eF7c4mOj2qpiDnA9yjsggmZ9Y2jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m20aeAvrYiWwD5w+UxI9fvU/QM+1kOJRt5gC6vWIdpU=;
 b=hy5s4BASnJ8hBzmmcHHQg0kCiJ3rxvxhR7SvoLys/F0IbSU4LMIIBkQu/LdueA9oU6f2CM5jsv+iv09Ml93s2v7TeYctssBwzBv70n06SR3zfqYaPEqkx23Fk2kybjX5s/A5vsyx/Jn3cpoKlZ1mIGFxBMr/PTIcDO6fye4BMuUUkGkXz5XSqH5Qsaj2V5sbcBusjeF/k+04nhzoZRbVvDQ18KskdexwcWh5cCpjfcU1z8OOEa6VTawVBD3sVqjURlXQf45wzCGo47WWt3+XUCKeaycDRq5ofpXQCvTMz2vlKbvWMdsruQ/Akm9cSGQNoBfGtGyzFr2w8Ufa5n4G+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m20aeAvrYiWwD5w+UxI9fvU/QM+1kOJRt5gC6vWIdpU=;
 b=nnBMzCPqWOj1CxU/4W9y9q1J/PCvEcHZHoXax2t9DAj4LDhPpoNWX/UL+IigkgcGaca+3Sv4hAwuB3rBkI6Zfhs+tQKeYBSvh2fKb5EcgitI72INh/vEYUUnzV+W5hVLtvxX+N78ZxWRcJlbx0u64/PWdo42PoegAg60i6nZoe8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 18:49:12 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 18:49:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/8] HMM profiler interface
Thread-Topic: [PATCH v2 0/8] HMM profiler interface
Thread-Index: AQHYDlNeAk9j2zu6eUKn/QFVl0OyHaxt0lbq
Date: Fri, 21 Jan 2022 18:49:12 +0000
Message-ID: <BL1PR12MB51442163F40284089C521BD9F75B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T18:49:11.534Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 7d14bae2-aaeb-1115-13c6-0b746a139688
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 200a9383-dc28-4347-0fce-08d9dd0eb742
x-ms-traffictypediagnostic: DM6PR12MB4843:EE_
x-microsoft-antispam-prvs: <DM6PR12MB484339121A46C680A40B5C47F75B9@DM6PR12MB4843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKMuCvppOzA06Vlg31KjRKeuKo97hsVHOz05xuJ/D0ipESpTDTyBIws9mqvZv6Uh1uyscRGpMtFTc/Iz+l4hXuBu9C7YHV7PnLqTJJqNLJkMsKl1Ons46uMcLnMiHc68zYeBrulhS68jM1crZQR0puja/jsaSmDPCZK5dqJoJu11e2VZX4aPeEc9gofsURhJ4JCD0PE2s8ZwhULNfmfqMKaKnXpCvb4Fm8SeTnjHx+Nc0sAgPg8QzzUIKyBKhKHdwM+fX/G42EYw1FoTB4/Av293OWJCAlHjfdGMOyK7USeJg+j23FccdKfxMbbfNBQHmuN5j9HJ4eTvq7QNDGm7X/tioIT+rCT5/O1mMIaf7kZKa84CX3N884sSILcrkmvVfEFtcBDPYbbcMSKwrwaC3Kswtf8AjC+ggps9mEN0VwUDW3bHydb1OFg+3cvxyaKwdz/OKBdAf0s3J3eNpjTnx9fpaAqy2sGODY/+8bd0J0wyMLgBnOLla6yOWVgvPNDPt6pbekBJ/DTSu0AWoZQDOj5AlkgjhS53f0tUGDR8NtXqO/yVaAg671Zrjv3BSejQTVvZzWU2amxDujyFx9rJjZiR+3BmjqQE/HMPaYLdCb3Pi84Gzkh2BJvljelvUOl41b1mBxIKId0somm+ct0NkXUBv+YUxVOFG3nJ8A+/nHrfHWIQUHkvgE2QVfe8lZ26tX8Q8HPwGme3iT7s8GcZ6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(4326008)(186003)(33656002)(508600001)(64756008)(66946007)(66446008)(76116006)(66556008)(66476007)(6506007)(53546011)(26005)(8676002)(122000001)(5660300002)(8936002)(9686003)(38100700002)(71200400001)(110136005)(52536014)(86362001)(19627405001)(316002)(83380400001)(7696005)(55016003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wV5ogV7O+soAkOjQTikpJEblZOU2TDvmBSpJRpXMvqfUr9oXqEzVsmDuqLhN?=
 =?us-ascii?Q?z1VkVGGVwmhDVE/rYIafM9gfhXYMBKUiGeOHfUMnKuqHr91P5jSBmDIBqRu4?=
 =?us-ascii?Q?EGfEL2wbLz1tOmc+LIHEb3XMlwd5ozsal1dLJh+f5NgcOVtkBExfaQwC/Wyw?=
 =?us-ascii?Q?tcf6FSTwVnoBWkiBFvQIQ63zCl1uZijwaRba2yDJ2iwKMMCPBCC2NgCPNSI4?=
 =?us-ascii?Q?mndPoBHvo8gu3rLzeMy3XW06vToTPB8i6enKmGMkRUCyXMun3v3NNP8pXJmU?=
 =?us-ascii?Q?wT/ywVCYL9dPMDf8Qosz/09BpurJh1NM1IYBoh1qv8MlNJjCm0h30vbqikcN?=
 =?us-ascii?Q?EqK8sjjCEOAE/g0WPF49JwC65rR5jbTZjwsCuTF05Q9f40KqCc5pKOYzKbqz?=
 =?us-ascii?Q?AE3qwCEQgU8qtbF9F1HB6Lq3cnVEKenvq9f2+vt2gzNKYBGVj20/NpufEMSk?=
 =?us-ascii?Q?/nO8TGhb3fCLLOGXNKzS2YN9l0g80BfYnDzJTOwgRxNVGqBN7uWgcQ2vzQg7?=
 =?us-ascii?Q?fnIbOhWC9yz2K1xJlCkGYGgIO4B/X7ZCMtEr3Bo217qPHkr4y7qjb9V6Wznj?=
 =?us-ascii?Q?qQvABVG7SXhqHke53w57lj6NKPuMScn6cgx4lpu11w3C04iN+4l7puBe/878?=
 =?us-ascii?Q?u/+Uy+eKWX4zsohtUPc7CPOB3uh9RQbHZyXCu4ugSHgvKbDiqUer3LOQ4Vod?=
 =?us-ascii?Q?7orwfgJGii93a/IfOVHpRSpEPK/CBnBAEhgibZu45dXgNrkAq+lGeu929Gxv?=
 =?us-ascii?Q?dLp+qB0GXP0R+LmSATUTz7SnahkMGDSLlxCoPSSEKT1YQ9OITJOfakvyLf7f?=
 =?us-ascii?Q?gooejsPMQlZpwkj7WmfEcgUWowHM4NSodt+WeOm8Qdr4ziRzV5pv+7xX6VWw?=
 =?us-ascii?Q?Zy8IOgXy7Y3Qv+1KdpU2MC/a0Gc2amAF1DE1qzEbx9D/bqQAk+dWYunqOg8C?=
 =?us-ascii?Q?P8ZSk8onjcCp2qocD13H49oVEn1MCFfnjQq16FQbskqkzM2PWfjVHxNBAdSZ?=
 =?us-ascii?Q?a1RYPvGOtLkNIphGnUDdQKb1kVHemM3XOtIdyWDgdZwKzPIrjwAKMSx59VVf?=
 =?us-ascii?Q?8LaUR1Qp8uD6DvYZKqJfWWHN9Kyc2nWlGDm9FJBD8PSRNvdEN/w10/36Danc?=
 =?us-ascii?Q?diikhQirF7wVxt1cFadIjqYk0M65yOpl0RomsAXrIsiIKIuVNe4fA2bflFiL?=
 =?us-ascii?Q?vD3Y5zyB1dRgSZ4hK1pLc++Q9lZYTGiizyuGJxaN8+CNTH+TRC4Kj2/xCyFe?=
 =?us-ascii?Q?xcTVOaGx3ugN3ur0b2mo0XG4Gbbz4WXUERKqyy8BLdB6Cow3edzp2P3YRDOF?=
 =?us-ascii?Q?RPmpApr0wjL2htImtheGa75HkpbCF1xueQCdXZMHyRU4WzpjxZuOLBuyvg/8?=
 =?us-ascii?Q?1YPegzIwkN8VKWVlCviW0CCviHxuYhA8Rqvwd7k7EPsEhulmRxvRhyj4tNtb?=
 =?us-ascii?Q?EfasKmbVIRleX8gNvxK8+Sj8sGh4yWAORhBWZ/0USgA+c/dllf2YhDxsXiuU?=
 =?us-ascii?Q?PoiPd0/ApfNMXX00knzENT0z/e2xtlCQ5S+gh6ugEuukkcV+TPfE9tkSGzgb?=
 =?us-ascii?Q?Hb2aOxcXr03wWdsvIO8pQpzeDomRxmcQMhTp93QPbEkxTroeg5lEaU5JD/ps?=
 =?us-ascii?Q?zxgWeVDjxcSEqMLv8P1eYPI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442163F40284089C521BD9F75B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200a9383-dc28-4347-0fce-08d9dd0eb742
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 18:49:12.1914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4/fssE9u+a24+/Zkx7dJ/JLP3RZ9+YkcUpM4W0WH+ho5ZBdgV2/TUsdwCNzf0Yih1eWJteFCCdyXdI8eIk7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4843
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51442163F40284089C521BD9F75B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Please provide a link to the proposed userspace branch that makes use of th=
is.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Philip Y=
ang <Philip.Yang@amd.com>
Sent: Thursday, January 20, 2022 6:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>
Subject: [PATCH v2 0/8] HMM profiler interface

The ROCm profiler would expose the data from KFD profiling APIs to
application developers to tune the applications based on how the address
range attributes affect the behavior and performance.

Per process event log use the existing SMI (system management interface)
event API. Each event log is one line of text with the event specific
information.

v2:
 * Keep existing events behaviour
 * Use ktime_get_boottime_ns() as timestamp to correlate with other APIs
 * Use compact message layout, stick with existing message convention
 * Add unmap from GPU event

Philip Yang (8):
  drm/amdkfd: Correct SMI event read size
  drm/amdkfd: Add KFD SMI event IDs and triggers
  drm/amdkfd: Enable per process SMI event
  drm/amdkfd: Add GPU recoverable fault SMI event
  drm/amdkfd: add migration SMI event
  drm/amdkfd: Add user queue eviction restore SMI event
  drm/amdkfd: Add unmap from GPU SMI event
  drm/amdkfd: Bump KFD API version for SMI profiling event

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  67 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  37 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 163 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  63 +++++--
 include/uapi/linux/kfd_ioctl.h                |  30 +++-
 11 files changed, 343 insertions(+), 65 deletions(-)

--
2.17.1


--_000_BL1PR12MB51442163F40284089C521BD9F75B9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please provide a link to the proposed userspace branch that makes use of th=
is.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Philip Yang &lt;Philip.Yang@a=
md.com&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 6:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang@amd.com&gt;; Kuehling, Felix &lt;Fe=
lix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 0/8] HMM profiler interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The ROCm profiler would expose the data from KFD p=
rofiling APIs to<br>
application developers to tune the applications based on how the address<br=
>
range attributes affect the behavior and performance.<br>
<br>
Per process event log use the existing SMI (system management interface)<br=
>
event API. Each event log is one line of text with the event specific<br>
information.<br>
<br>
v2:<br>
&nbsp;* Keep existing events behaviour<br>
&nbsp;* Use ktime_get_boottime_ns() as timestamp to correlate with other AP=
Is<br>
&nbsp;* Use compact message layout, stick with existing message convention<=
br>
&nbsp;* Add unmap from GPU event<br>
<br>
Philip Yang (8):<br>
&nbsp; drm/amdkfd: Correct SMI event read size<br>
&nbsp; drm/amdkfd: Add KFD SMI event IDs and triggers<br>
&nbsp; drm/amdkfd: Enable per process SMI event<br>
&nbsp; drm/amdkfd: Add GPU recoverable fault SMI event<br>
&nbsp; drm/amdkfd: add migration SMI event<br>
&nbsp; drm/amdkfd: Add user queue eviction restore SMI event<br>
&nbsp; drm/amdkfd: Add unmap from GPU SMI event<br>
&nbsp; drm/amdkfd: Bump KFD API version for SMI profiling event<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 7 +-<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; |&nbsp; 11 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_migrate.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 67 ++++---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_migrate.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 37 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c&nbsp;&nbsp; | 163 +++++++=
++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h&nbsp;&nbsp; |&nbsp; 19 +-=
<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 63 +++++--<br>
&nbsp;include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 30 +++-<br>
&nbsp;11 files changed, 343 insertions(+), 65 deletions(-)<br>
<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442163F40284089C521BD9F75B9BL1PR12MB5144namp_--
